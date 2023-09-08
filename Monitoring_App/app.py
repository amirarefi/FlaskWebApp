import psutil
#import psutil module in full
from flask import Flask, render_template
#import the Flask class (used for creating web applications) from the flask module
#import the render_template class for styling


app = Flask(__name__)
#define a Flask app (create an instance of Flask class) and pass the __name__ variable as a parameter to it. 
#The __name__ variable is a special Python variable that represents the name of the current module.

@app.route("/")  
#define the location where the app will be running, here is the root
def index():     #define a function named index
    cpu_percent = psutil.cpu_percent()
    mem_percent = psutil.virtual_memory().percent
    Message = None
    if cpu_percent > 80 or mem_percent > 80:
        Message = "High CPU or Memory Utilisation detected, please scale up"
    return render_template("index.html", cpu_metric=cpu_percent, mem_metric=mem_percent, message=Message)
    
if __name__ == '__main__':
    #when  the __name__ variable is set to '__main__'. 
    #This ensures that the script is being run as the main program or when the script is run directly not as a module. This check prevents the code running seperately
    app.run(host='0.0.0.0', port=5000) 
     #set the host to '0.0.0.0' so this Flask application will be accessible from any IP address 