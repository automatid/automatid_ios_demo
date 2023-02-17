import subprocess
import os
import sys

def displayErrorMessage(my_message):
    message = 'tell app "Finder" to display dialog "' + my_message + '" buttons "OK" default button 1 with title "Failed appscript.py" with icon stop'
    p = subprocess.Popen(['osascript', '-e', message], stdout=subprocess.PIPE)
    out, err = p.communicate()
    sys.exit(1)

def displayNotificationMessage(my_message):
    p = subprocess.Popen(['osascript', '-e', 'display notification "'+ my_message +'" with title "Project Pre-Build"'], stdout=subprocess.PIPE)
    out, err = p.communicate()



if(len(sys.argv)<3):
    errorMessage = 'appscript.py require at least 2 custom params, params are: ' + str(sys.argv)
    displayErrorMessage(errorMessage)

path = sys.argv[1]
sdkName = sys.argv[2]

def recursiveAppScript(path, sdkName):
    superFolder = os.path.abspath(os.path.join(path, ".."))
    #superFolder = os.path.abspath(os.path.join(superFolder, ".."))

    for f in os.listdir(superFolder):
        scanningFolder = os.path.abspath(os.path.join(superFolder, f))
        if not scanningFolder == path:
            if os.path.isdir(scanningFolder):
                possiblePyScript = os.path.join(scanningFolder,'appscript.py')
                if os.path.isfile(possiblePyScript):
                    projFileName = gatherProjectFilename(scanningFolder)
                    projFileName = os.path.basename(scanningFolder)

                    scriptsFolder = os.path.join(path, 'Pods')
                    scriptsFolder = os.path.join(scriptsFolder, 'Scripts')

                    p = subprocess.Popen(['/usr/bin/python3', possiblePyScript, scanningFolder, projFileName, scriptsFolder, sdkName], stdout=subprocess.PIPE)
                    out, err = p.communicate()
                    if p.returncode != 0:
                        displayErrorMessage('/usr/bin/python3' + ' ' + possiblePyScript + ' ' + scanningFolder)


#start script

def getSpectFileInPath(projectPath):
    for f in os.listdir(projectPath):
        scanningFolder = os.path.abspath(os.path.join(projectPath, f))
        if os.path.isfile(scanningFolder):
            if (f.endswith(".podspec")):
                return f
    return None

def gatherProjectFilename(projectPath):
    spec = getSpectFileInPath(projectPath)
    if not spec:
        return None
    file = os.path.join(projectPath, spec)
    with open(file) as f:
        lines = f.readlines()
        for line in lines:
            s = line.strip()
            if(s.startswith('s.name') and '=' in s):
                projName = s.split("=")[1]
                projName = projName.strip()
                projName = projName.strip("'")
                return projName
    return None



displayNotificationMessage('App Script')
recursiveAppScript(path, sdkName)
