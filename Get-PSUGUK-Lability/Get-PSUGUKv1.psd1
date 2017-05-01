@{
    AllNodes = @(
        
        @{
            NodeName         = '*';
            PrefixLength     =  24;
            AddressFamily    = 'IPv4';
            InterfaceAlias   = 'Ethernet';
            DefaultGateway   = '10.200.0.2';
            DnsServerAddress = '8.8.8.8','8.8.4.4';
        }
        @{
            NodeName         = 'GETPSUGUK01';
            IPAddress        = '10.200.0.101';
        }
        @{
            NodeName         = 'GETPSUGUK02';
            IPAddress        = '10.200.0.102';
        }
        @{
            NodeName         = 'GETPSUGUK03';
            IPAddress        = '10.200.0.103';
        }

    )
}
