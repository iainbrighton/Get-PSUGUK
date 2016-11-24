@{
    AllNodes = @(
        @{
            NodeName            = '*';
            PrefixLength        =  24;
            AddressFamily       = 'IPv4';
            InterfaceAlias      = 'Ethernet';
            DefaultGateway      = '10.200.0.2';
            DNSServerAddress    = '8.8.8.8','8.8.4.4';
            
            Lability_Media      = '2016_x64_Datacenter_Nano_EN_Eval'; ## Override the default media for all VMs
            Lability_SwitchName = 'NAT';                              ## Override the default network vSwitch for all VMs
        }
        @{
            NodeName            = 'GETPSUGUK01';
            IPAddress           = '10.200.0.101';
        }
        @{
            NodeName            = 'GETPSUGUK02';
            IPAddress           = '10.200.0.102';
        }
        @{
            NodeName            = 'GETPSUGUK03';
            IPAddress           = '10.200.0.103';
        }
    );
    NonNodeData = @{

        Lability = @{

            Module = @(

                ## Define the PowerShell modules that we would like copied to each node

                @{ Name = 'OperationValidation'; MinimumVersion = '1.0.1'; }
                @{ Name = 'PSake'; MinimumVersion = '4.6.0'; }
                @{ Name = 'PSDeploy'; MinimumVersion = '0.1.24'; }
            )
            
            DscResource = @(

                ## Define the PowerShell DSC resource modules that we would like copied to each node
                ## If you were using a pull server, you wouldn't need this ;)
                
                @{ Name = 'xNetworking'; MinimumVersion = '3.0.0.0'; }
            )

            ## You can also define media, resources and network configurations here.
            ## See about_Media, about_CustomResources and about_Networking help topics for more information
        }
    }
}
