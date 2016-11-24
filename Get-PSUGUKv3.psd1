@{
    AllNodes = @(
        @{
            NodeName               = '*';
            PrefixLength           =  24;
            AddressFamily          = 'IPv4';
            InterfaceAlias         = 'Ethernet';
            DefaultGateway         = '10.200.0.2';
            DNSServerAddress       = '8.8.8.8','8.8.4.4';
            
            Lability_Media         = '2016_x64_Datacenter_Core_EN_Eval'; <# !! Updated to use Server Core #>
            Lability_StartupMemory =  2GB;                               <# !! Added to support Server Core #>
            Lability_SwitchName    = 'NAT';
        }
        @{
            NodeName               = 'GETPSUGUK01';
            IPAddress              = '10.200.0.101';
        }
        @{
            NodeName               = 'GETPSUGUK02';
            IPAddress              = '10.200.0.102';
        }
        @{
            NodeName               = 'GETPSUGUK03';
            IPAddress              = '10.200.0.103';
        }
    );
    NonNodeData = @{

        Lability = @{

            Module = @(
                @{ Name = 'OperationValidation'; MinimumVersion = '1.0.1'; }
                @{ Name = 'PSake'; MinimumVersion = '4.6.0'; }
                @{ Name = 'PSDeploy'; MinimumVersion = '0.1.24'; }
            )
            
            DscResource = @(
                @{ Name = 'xNetworking'; MinimumVersion = '3.0.0.0'; }
            )
        }
    }
}
