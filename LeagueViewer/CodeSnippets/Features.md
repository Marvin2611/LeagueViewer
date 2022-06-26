# List of missing/nicetohave features:
----------------------------------------------------------------
ChampionsView
- Sorting champions by level / last time played / chest granted

# Problems im still aware of:
----------------------------------------------------------------
Api / Error Extension
- Checking the possible thrown codes

League_v4
- For some reason there seems to be a problem with the api key

ChampionsView / MatchesView
- Refreshing by clicking adds on list

ProfileViewModel
- Api throws a Code 403 (Forbidden access) error

LoginView
- Input fields must be protected, not allowing every input

URLBuilder func checkSummonerName
- Missing checks for special characters that need to be converted (f.e " " = "%20")

Extensions UnixTime
- There seems to be a problem with the conversion to years 

Redundance
- The api calls in the viewmodels can be structed together

# Working Features:
----------------------------------------------------------------

Submitting summoner name and region
Checking your profile
Checking your champion statistics
Checking general match data

# API Call on the Riot API:
----------------------------------------------------------------

You first call a request with the summoner name on the Summoner-v4 Api.
That call returns the summoner id and the summoner puuid.
Those two ids are used in most calls related to the summoner
Semaphores are needed, as rate limit is restricted to 20 calls
