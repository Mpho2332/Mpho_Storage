name = input("Enter your name and lastname:")
weight = int(input("Enter your weight:"))
height = int ( input("Enter your height:"))
BMI = (weight*703)/(height**2)
print (BMI)
if BMI < 18.5:
    print (" you are underweight")
elif BMI <= 24.9:
    print ("you are normal weight")
elif BMI <= 29.9:
    print (" overweight")
elif BMI<= 34.9:
    print ( "obese")
elif BMI <= 39.9:
    print ("severly obese")
elif BMI >= 40:
    print ("morbidly obese")
else:
    print("enter correct input")


             
