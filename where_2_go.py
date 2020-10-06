import urllib.request as request
import json


def intersection(lst1, lst2): 
    return list(set(lst1) & set(lst2)) 

with request.urlopen('https://gist.githubusercontent.com/benjambles/ea36b76bc5d8ff09a51def54f6ebd0cb/raw/ee1d0c16eaf373cccadd3d5604a1e0ea307b2ca0/users.json') as response:
    user_dataset = json.loads(response.read().decode())
    



with request.urlopen('https://gist.githubusercontent.com/benjambles/ea36b76bc5d8ff09a51def54f6ebd0cb/raw/ee1d0c16eaf373cccadd3d5604a1e0ea307b2ca0/venues.json') as response:
    venues_dataset = json.loads(response.read().decode())


for user_rows in user_dataset:
    for venue_rows in venues_dataset:
        wont_eat_list = [item.lower() for item in user_rows["wont_eat"]]
        food_list = [item.lower() for item in venue_rows["food"]]
        food_intersec=intersection(wont_eat_list, food_list)
        #if food_intersec:
        calcs=len(food_list)-len(food_intersec)
        if calcs==0:
            #accumulate the places good to go
            print("User "+ str(user_rows["name"])+" has "+str(calcs)+" Options for FOOD on :" +venue_rows["name"])
    