
[DSCLocalConfigurationManager()]
configuration Get-PSUGUKLCMConfig {

    Node $AllNodes.NodeName.ToUpper() {
        
        Settings {

            RebootNodeIfNeeded = $true;
            ConfigurationMode = 'ApplyAndAutocorrect';
            ActionAfterReboot = 'ContinueConfiguration';
        }
    }
}

configuration Get-PSUGUK {
    param ( )

    Import-DscResource -ModuleName xNetworking;

    node $AllNodes.NodeName {

        if ($node.IPAddress) {
        
            xIPAddress 'IP' {

                IPAddress      = $node.IPAddress;
                InterfaceAlias = $node.InterfaceAlias;
                AddressFamily  = $node.AddressFamily;
                PrefixLength   = $node.PrefixLength;
            }
        }
        
        if ($node.DefaultGateway) {
        
            xDefaultGatewayAddress 'Gateway' {

                Address        = $node.DefaultGateway;
                InterfaceAlias = $node.InterfaceAlias;
                AddressFamily  = $node.AddressFamily;
            }
        }

        if ($node.DnsServerAddress) {

            xDNSServerAddress 'DNSServer' {

                Address        = $node.DNSServerAddress;
                InterfaceAlias = $node.InterfaceAlias;
                AddressFamily  = $node.AddressFamily;
            }
        }

    } #end AllNodes.NodeName
    
} #end configuration
