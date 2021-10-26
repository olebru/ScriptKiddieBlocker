# ScriptKiddieBlocker

Powershell script that blocks source ip of script kiddies
Accountnames in the whitelist.txt file (comma seperated) is ignored.

In the XML file:
Replace all occurences of ##USER## with computer\accountwithadminpriv or Ddomain\accountwithadminpriv
Replace all occurences of ##Path## with full path to folder containing script.

Import the XML file as a new scheduled task.
Make sure that c:\temp exists, it is used for logging.