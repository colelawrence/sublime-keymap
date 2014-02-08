find_under_expand = (cm)->
  selections = cm.getSelections()
  return if selections.length is 0
  if selections.length >= 1
    {ch,line} = cm.getCursor()
    if selections[0] is ""
      # No selection and single cursor
      lineContent = cm.getLine(line)

      # Select word the cursor is on
      beginning = lineContent[...ch]
      ending = lineContent[ch...]
      
      chB = chA = ch
      if before = beginning.match /([\w\d\_\$\@]+)$/
        chA -= before[1].length
      if after = ending.match /^([\w\d\_\$]+)/
        chB += after[1].length

      cm.setSelection {line,ch:chA}, {line,ch:chB}
    else
      selected = selections[0]
      lastLine = cm.lastLine()
      findInLine = ///^(.*)(#{selected})///
      finder=(lineNumber)->
        lineContents = cm.getLine lineNumber
        if line is lineNumber
          spaces = Array(ch + selected.length+1).join(" ")
          # Replace Characters behind us because we don't want to reselect the same stuff
          lineContents = spaces + lineContents[ch + selected.length...]
        if match = lineContents.match findInLine
          chA = match[1].length
          chB = chA + match[2].length
          cm.addSelection {line:lineNumber,ch:chA}, {line:lineNumber,ch:chB}
          return true
        return false
      for currentLine in [line...lastLine]
        if finder currentLine
          return null
      for currentLine in [0...line-1]
        if finder currentLine
          break
  return null