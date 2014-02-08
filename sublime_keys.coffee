#_require key_scripts/find_under_expand
sublimeKeys = {}

# Add next occurence to selection
sublimeKeys["Ctrl-D"] = find_under_expand

CodeMirror.defineOption 'sublimeKeys', false, (cm, val)->
  console.log val
  cm.addKeyMap sublimeKeys