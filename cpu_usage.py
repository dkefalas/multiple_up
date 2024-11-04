import re
import sys
import time
import subprocess

def extract_cpu_usage(top_output):
    # Initialize the CPU usage variable
    cpu_usage = None

    # Split the output into lines
    lines = top_output.strip().split('\n')

    # Iterate through each line to find the one containing 'nr-cuup'
    for line in lines:
        if 'nr-cuup' in line:
            # Use regex to extract the CPU usage percentage
            columns = line.split()
            if len(columns) > 8:
                cpu_usage = columns[8]
            break
    return cpu_usage

def save_cpu_usage_to_file(cpu_usage, filename='cpu_usage.txt'):
    if cpu_usage is not None:
        with open(filename, 'a') as file:  # Use 'a' mode to append to the file
            file.write(f'nr-cuup CPU Usage: {cpu_usage}%\n')
    else:
        print("nr-cuup process not found in the provided top output.")

if __name__ == "__main__":
    while True:
        # Run the top command and capture its output
        process = subprocess.Popen(['top', '-b', '-n', '1'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()

        if process.returncode == 0:
            top_output = stdout.decode('utf-8')
            cpu_usage = extract_cpu_usage(top_output)
            save_cpu_usage_to_file(cpu_usage)
        else:
            print(f"Error running top command: {stderr.decode('utf-8')}")

        # Sleep for a specified interval before the next iteration
        time.sleep(1)  # Adjust the interval as needed


