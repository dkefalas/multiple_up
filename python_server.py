import os
import threading
import subprocess

# Print current working directory and list files to debug
print("Current working directory:", os.getcwd())
print("Files in the directory:", os.listdir())

# Get the absolute path of the script
script_path = os.path.abspath("exec_iperf.sh")
print(f"Absolute path of the script: {script_path}")

# Function to execute the shell script with a given parameter
def execute_script(param):
    try:
        result = subprocess.run([script_path, param], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        #print(f"Output for {param}: {result.stdout.decode()}")
        #print(f"Error for {param}: {result.stderr.decode()}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to execute {script_path} with parameter {param}: {e}")
    except FileNotFoundError as fnf_error:
        print(f"File not found error: {fnf_error}")

# Parameters to be passed to the script
params = ["ue2", "ue3", "ue4"]

# Creating threads for each parameter
threads = []
for param in params:
    thread = threading.Thread(target=execute_script, args=(param,))
    threads.append(thread)
    thread.start()

# Waiting for all threads to complete
for thread in threads:
    thread.join()

print("All scripts executed.")

