from django.shortcuts import render, reverse
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
import subprocess

# Create your views here.

output = ""

def index(request):
    return render(request, "Compiler/index.html", {
        "output": output
        })

from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def run_code(request):
    if request.method == 'POST':
        code_input = request.POST.get('code_input', '')
        
        # Write the text into a file
        with open("input.txt", "w") as f:
            f.write(code_input)
                
        # Compile the program
        command = ['./output', 'input.txt', 'assembly.asm']
        with open('errors.txt', 'w') as f:
            proc = subprocess.Popen(command, stdout=f)

        # Wait for the program to finish
        proc.wait()
        
        # Check if there are errors in the code
        errors = ""
        with open("errors.txt", "r") as f:
            errors = f.read()
            
        if (errors != ""):
            # Render the page and pass the errors
            return JsonResponse({'output': errors})
        
        with open('assembly.asm', 'rt') as f:
            asm_output = f.read()

                    
        # Run the assembly code inside of a docker container
        subprocess.run(['docker', 'build', '-t', 'assembly', '.'])
                
        docker_command = ["docker", "run", "assembly"]
        
        with open("output.txt", "w") as f:
            proc = subprocess.Popen(docker_command, stdout=f)
            
        proc.wait()

        
        # Get the output of the program
        with open("output.txt", "r") as f:
            output = f.read()
        
        return JsonResponse({'output': output, 'asm':asm_output})


    return render(request, "Compiler/index.html", {"output": "Hello!"})
    
def output_page(request):
    output = request.GET.get('output', '')
    output = output[12:-2]
    output = output.split("\\n")
    return HttpResponseRedirect(reverse("index"))