# from math import radians, cos, sin, asin, sqrt

# def haversine(lon1, lat1, lon2, lat2):
#     """
#     Calculate the great circle distance between two points 
#     on the earth (specified in decimal degrees)
#     """
#     # convert decimal degrees to radians 
#     lon1, lat1, lon2, lat2 = map(radians, [lon1, lat1, lon2, lat2])

#     # haversine formula 
#     dlon = lon2 - lon1 
#     dlat = lat2 - lat1 
#     a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
#     c = 2 * asin(sqrt(a)) 
#     r = 6371 # Radius of earth in kilometers. Use 3956 for miles
#     return c * r

# center_point = [{'lat': -19.037482407531193, 'lng': 72.84214176780718}]
# test_point = [{'lat': -19.04626633908517, 'lng': 72.8281398391472}]

# lat1 = center_point[0]['lat']
# lon1 = center_point[0]['lng']
# lat2 = test_point[0]['lat']
# lon2 = test_point[0]['lng']

# radius = 1.00 # in kilometer

# a = haversine(lon1, lat1, lon2, lat2)

# print('Distance (km) : ', a)
# if a <= radius:
#     print('Inside the area')
# else:
#     print('Outside the area')

# from geopy import geocoders

# gn = geocoders.GeoNames(username='udaykha')
# tokyo = gn.geocode('Tokyo')
# print(tokyo)

# from geopy.geocoders import Nominatim
# geolocator = Nominatim(user_agent='myapplication')
# location = geolocator.geocode("Tokyo")
# print(location.latitude)
# print(location.longitude)


from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent='udaykhalsa')

Latitude = "82.5555"
Longitude = "80.0005"





location = geolocator.reverse(Latitude+","+Longitude, language='en')

address = location.raw['address']
print(address)

try:
    print(address['city'])
except Exception as e:
    print(e)
    print(address['state_district'])

print(address['country'])

