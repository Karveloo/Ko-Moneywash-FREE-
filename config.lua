Config = {}

Config.pesulat = {
    {
        nimi = "1",
        sijainti = vector3(-1453.6038, -186.8366, 62.3851),
        pesuProsentti = 70,
        jobi = { nimi = "kona", arvo = 0 }  -- "none" tarkoittaa kuka vaa voi käyttää jos jobin grade esim 2 nii pelaajat joilla se jobi ja yli 2 arvo voi käyttää
    },
    {
        nimi = "2",
        sijainti = vector3(252.3, 221.4, 106.3),--sijainti
        pesuProsentti = 80, --paljo pelaajat saa takasin prosenttein 80 = 80%
        jobi = { nimi = "none", arvo = 0 }  -- voi lisää jobi jos käytät jobia none nii muista laittaa arvo 0
    }
}

Config.DrawDistance = 10.0 -- Älä koske
Config.MarkerType = 1 -- Älä koske
Config.MarkerSize = { x = 1.5, y = 1.5, z = 0 } -- Älä koske
Config.MarkerColor = { r = 255, g = 255, b = 0 } -- Älä koske

Config.WashMoneyPercentage = 0.8  -- Älä koske

Config.DiscordWebhook = "TÄHÄN WEBHOOKKI"

Config.Prop = 'prop_washer_01'