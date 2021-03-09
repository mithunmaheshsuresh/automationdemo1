import barnum
import time
import random
from robot.api.deco import keyword


def citycombo(zip):
    fakezip = barnum.create_city_state_zip(str(zip))
    city_state_zip = {'zip': fakezip[0], 'city': fakezip[1], 'state': fakezip[2]}
    return city_state_zip


def fakephone(zip):
    bPhone = barnum.create_phone(zip)
    phone = bPhone[1:4] + '555' + bPhone[9:14]
    return phone


def fakeemail():
    datetime = time.localtime()
    email = 'robot+' + str(datetime[1])+'-' + str(datetime[2]) + '-' + str(datetime[0]) + '-T' + str(datetime[3]) + '-' + str(datetime[4]) + '-' + str(datetime[5]) + '@peapod.com'
    return email


def fakeaddrln2():
    randomnumber=random.randint(0,1000000)
    fakeln2='Suite '+str(randomnumber)
    return fakeln2


def cleanzip(zip):
    if len(str(zip)) == 4:
        newzip = '0'+str(zip)
        return newzip
    else:
        return zip


@keyword('Generate Fake Consumer Address Form Details')
def fakeconsumerinfo(zip=60606):
    zip2 = cleanzip(zip)
    address_combo = citycombo(zip2)
    address_combo["address"] = barnum.create_street()
    address_combo["phone"] = fakephone(address_combo['zip'])
    address_combo["email"] = fakeemail()
    address_combo["firstName"] = barnum.create_name()[0]
    address_combo["lastName"] = barnum.create_name()[1]
    address_combo["address2"] = fakeaddrln2()
    return address_combo


@keyword('Generate Fake Merchant Address Form Details')
def fakemerchantinfo(zip=60606):
    zip2 = cleanzip(zip)
    address_combo = citycombo(zip2)
    address_combo["address"] = barnum.create_street()
    address_combo["phone"] = fakephone(address_combo['zip'])
    address_combo["email"] = fakeemail()
    address_combo["firstName"] = barnum.create_name()[0]
    address_combo["lastName"] = barnum.create_name()[1]
    address_combo["company"] = barnum.create_company_name()
    address_combo["extension"] = random.randint(1000, 10000)
    return address_combo


if __name__ == "__main__":
    fakeconsumerinfo()