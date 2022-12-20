{pkgs, config, lib, ...}: {
	networking.nat = {
	  enable = true;
	  internalInterfaces = ["ve-+"];
	  externalInterface = "ens3";
	  # Lazy IPv6 connectivity for the container
	  enableIPv6 = true;
	};

	containers.nextcloud = {
	  autoStart = true;                
	  privateNetwork = true;           
	  hostAddress = "192.168.100.10";
	  localAddress = "192.168.100.11";
	  hostAddress6 = "fc00::1";
	  localAddress6 = "fc00::2";
	  config = { config, pkgs, ... }: {

	    services.nextcloud = {                     
	      enable = true;                   
	      package = pkgs.nextcloud24;
	      hostName = "localhost";
	      config.adminpassFile = pkgs.writeText "adminpass" "test123"; # DON'T DO THIS IN PRODUCTION - the password file will be world-readable in the Nix Store!
	    };

	    system.stateVersion = "22.05";

	    networking.firewall = {
	      enable = true;
	      allowedTCPPorts = [ 80 ];
	    };

	    # Manually configure nameserver. Using resolved inside the container seems to fail
	    # currently
	    environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

	  };
	};

}