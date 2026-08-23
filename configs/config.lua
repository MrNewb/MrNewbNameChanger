--		___  ___       _   _                  _      _____              _         _
--		|  \/  |      | \ | |                | |    /  ___|            (_)       | |
--		| .  . | _ __ |  \| |  ___ __      __| |__  \ `--.   ___  _ __  _  _ __  | |_  ___
--		| |\/| || '__|| . ` | / _ \\ \ /\ / /| '_ \  `--. \ / __|| '__|| || '_ \ | __|/ __|
--		| |  | || |   | |\  ||  __/ \ V  V / | |_) |/\__/ /| (__ | |   | || |_) || |_ \__ \
--		\_|  |_/|_|   \_| \_/ \___|  \_/\_/  |_.__/ \____/  \___||_|   |_|| .__/  \__||___/
--									          							  | |
--									          							  |_|
--
--		  Need support? Join our Discord server for help: https://discord.gg/mrnewbscripts
--		  Check out my paid scripts and freebies at https://mrnewbscripts.tebex.io/
--		  If you need help with configuration or have any questions, please do not hesitate to ask.
--		  Docs Are Always Available At -- https://mrnewb.github.io/docs/
--

Config = {}

Config.Debug = false

Config.Items = {
    NameChangeVoucher = 'namechangevoucher',
    MarriageCertificate = 'blankmarriagecertificate',
    FilledCertificate = 'filledcertificate',
}

Config.NameFilter = {
    MaxLength = 32,
    BadWords = {
        'fart',
        'bitch',
        'fuck',
    },
}

Config.Marriage = {
    RequireJob = false,
    AllowedJobs = {
        'police',
        'judge',
        'pastor',
    },
}

Config.RecordsClerk = {
    Enabled = false,
    Price = 10000,
    Account = 'cash', -- cash | bank
    Cooldown = 86400, -- seconds per character
    Locations = {
        CityHall = {
            Coords = vector4(-540.6024, -206.1626, 37.6498, 207.1927),
            Model = 'ig_priest',
            Label = 'City Records Clerk',
            Scenario = 'WORLD_HUMAN_CLIPBOARD',
            SpawnRadius = 50.0,
            InteractDistance = 2.5,
        },
    },
}
