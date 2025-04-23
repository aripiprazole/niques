[
  {
    "key" = "shift+tab";
    "command" = "acceptAlternativeSelectedSuggestion";
    "when" = "suggestWidgetVisible && textInputFocus";
  }
  {
    "key" = "shift+enter";
    "command" = "acceptAlternativeSelectedSuggestion";
    "when" = "suggestWidgetVisible && textInputFocus";
  }
  {
    "key" = "tab";
    "command" = "acceptSelectedSuggestion";
    "when" = "suggestWidgetVisible && textInputFocus";
  }
  {
    "key" = "enter";
    "command" = "acceptSelectedSuggestion";
    "when" = "acceptSuggestionOnEnter && suggestWidgetVisible && suggestionMakesTextEdit && textInputFocus";
  }
  {
    "key" = "shift+cmd+space";
    "command" = "editor.action.triggerParameterHints";
    "when" = "editorHasSignatureHelpProvider && editorTextFocus";
  }
  {
    "key" = "cmd+k cmd+i";
    "command" = "editor.action.showHover";
    "when" = "editorTextFocus";
  }
  {
    "key" = "";
    "command" = "workbench.action.showErrorsWarnings";
    "when" = "editorTextFocus";
  }
  {
    "key" = "cmd+n";
    "command" = "workbench.action.files.newUntitledFile";
    "when" = "(!editorHasCodeActionsProvider && editorTextFocus) || !editorTextFocus";
  }
  {
    "key" = "cmd+/";
    "command" = "editor.action.commentLine";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "shift+alt+a";
    "command" = "editor.action.blockComment";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "";
    "command" = "editor.action.smartSelect.grow";
    "when" = "editorTextFocus";
  }
  {
    "key" = "ctrl+shift+left";
    "command" = "editor.action.smartSelect.shrink";
    "when" = "editorTextFocus";
  }
  {
    "key" = "ctrl+shift+cmd+left";
    "command" = "editor.action.smartSelect.shrink";
    "when" = "editorTextFocus";
  }
  {
    "key" = "cmd+.";
    "command" = "editor.action.quickFix";
    "when" = "editorHasCodeActionsProvider && editorTextFocus && !editorReadonly";
  }
  {
    "key" = "shift+alt+f";
    "command" = "editor.action.formatDocument";
    "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
  }
  {
    "key" = "cmd+k cmd+f";
    "command" = "editor.action.formatSelection";
    "when" = "editorHasDocumentSelectionFormattingProvider && editorHasSelection && editorTextFocus && !editorReadonly";
  }
  {
    "key" = "cmd+x";
    "command" = "editor.action.clipboardCutAction";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "shift+alt+down";
    "command" = "editor.action.copyLinesDownAction";
    "when" = "editorTextFocus && !editorReadonly && !editorHasSelection";
  }
  {
    "key" = "";
    "command" = "editor.action.duplicateSelection";
    "when" = "editorTextFocus && !editorReadonly && editorHasSelection";
  }
  {
    "key" = "shift+cmd+k";
    "command" = "editor.action.deleteLines";
    "when" = "textInputFocus && !editorReadonly";
  }
  {
    "key" = "ctrl+j";
    "command" = "editor.action.joinLines";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "ctrl+o";
    "command" = "lineBreakInsert";
    "when" = "textInputFocus && !editorReadonly";
  }
  {
    "key" = "cmd+enter";
    "command" = "editor.action.insertLineAfter";
    "when" = "editorTextFocus && !editorReadonly && !notebookEditorFocused";
  }
  {
    "key" = "alt+right";
    "command" = "cursorWordRight";
    "when" = "editorTextFocus && !inlineSuggestionVisible && !config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+right";
    "command" = "cursorWordPartRight";
    "when" = "editorTextFocus && !inlineSuggestionVisible && config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+left";
    "command" = "cursorWordLeft";
    "when" = "editorTextFocus && !config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+left";
    "command" = "cursorWordPartStartLeft";
    "when" = "editorTextFocus && config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+shift+right";
    "command" = "cursorWordRightSelect";
    "when" = "editorTextFocus && !config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+shift+right";
    "command" = "cursorWordPartRightSelect";
    "when" = "editorTextFocus && config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+shift+left";
    "command" = "cursorWordLeftSelect";
    "when" = "editorTextFocus && !config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+shift+left";
    "command" = "cursorWordPartStartLeftSelect";
    "when" = "editorTextFocus && config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+delete";
    "command" = "deleteWordRight";
    "when" = "textInputFocus && !editorReadonly && !config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+delete";
    "command" = "deleteWordPartRight";
    "when" = "editorTextFocus && !editorReadonly && config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+backspace";
    "command" = "deleteWordLeft";
    "when" = "textInputFocus && !editorReadonly && !config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+backspace";
    "command" = "deleteWordPartLeft";
    "when" = "editorTextFocus && !editorReadonly && config.intellij-idea-keybindings.useCamelHumpsWords";
  }
  {
    "key" = "alt+cmd+]";
    "command" = "editor.unfold";
    "when" = "editorTextFocus && foldingEnabled";
  }
  {
    "key" = "alt+cmd+[";
    "command" = "editor.fold";
    "when" = "editorTextFocus && foldingEnabled";
  }
  {
    "key" = "cmd+k cmd+]";
    "command" = "editor.unfoldRecursively";
    "when" = "editorTextFocus && foldingEnabled";
  }
  {
    "key" = "cmd+k cmd+[";
    "command" = "editor.foldRecursively";
    "when" = "editorTextFocus && foldingEnabled";
  }
  {
    "key" = "cmd+k cmd+j";
    "command" = "editor.unfoldAll";
    "when" = "editorTextFocus && foldingEnabled";
  }
  {
    "key" = "cmd+k cmd+0";
    "command" = "editor.foldAll";
    "when" = "editorTextFocus && foldingEnabled";
  }
  {
    "key" = "cmd+w";
    "command" = "workbench.action.closeActiveEditor";
  }
  {
    "key" = "cmd+d";
    "command" = "editor.action.addSelectionToNextFindMatch";
    "when" = "editorFocus";
  }
  {
    "key" = "cmd+u";
    "command" = "cursorUndo";
    "when" = "textInputFocus";
  }
  {
    "key" = "alt+down";
    "command" = "editor.action.moveLinesDownAction";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "alt+up";
    "command" = "editor.action.moveLinesUpAction";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "";
    "command" = "editor.action.toggleColumnSelection";
  }
  {
    "key" = "f3";
    "command" = "editor.action.nextMatchFindAction";
    "when" = "editorFocus";
  }
  {
    "key" = "cmd+g";
    "command" = "editor.action.nextMatchFindAction";
    "when" = "editorFocus";
  }
  {
    "key" = "enter";
    "command" = "editor.action.nextMatchFindAction";
    "when" = "editorFocus && findInputFocussed";
  }
  {
    "key" = "shift+f3";
    "command" = "editor.action.previousMatchFindAction";
    "when" = "editorFocus";
  }
  {
    "key" = "shift+cmd+g";
    "command" = "editor.action.previousMatchFindAction";
    "when" = "editorFocus";
  }
  {
    "key" = "shift+enter";
    "command" = "editor.action.previousMatchFindAction";
    "when" = "editorFocus && findInputFocussed";
  }
  {
    "key" = "alt+cmd+f";
    "command" = "editor.action.startFindReplaceAction";
    "when" = "editorFocus || editorIsOpen";
  }
  {
    "key" = "shift+cmd+f";
    "command" = "workbench.action.findInFiles";
  }
  {
    "key" = "shift+cmd+h";
    "command" = "workbench.action.replaceInFiles";
  }
  {
    "key" = "shift+alt+f12";
    "command" = "references-view.findReferences";
    "when" = "editorHasReferenceProvider";
  }
  {
    "key" = "";
    "command" = "editor.action.referenceSearch.trigger";
    "when" = "editorHasReferenceProvider && editorTextFocus && !inReferenceSearchEditor";
  }
  {
    "key" = "shift+cmd+b";
    "command" = "workbench.action.tasks.build";
  }
  {
    "key" = "";
    "command" = "workbench.action.tasks.reRunTask";
    "when" = "taskCommandsRegistered && !terminalFocus";
  }
  {
    "key" = "shift+cmd+d";
    "command" = "workbench.view.debug";
  }
  {
    "key" = "ctrl+f5";
    "command" = "workbench.action.debug.run";
    "when" = "debuggersAvailable && !inDebugMode && !terminalFocus";
  }
  {
    "key" = "f10";
    "command" = "workbench.action.debug.stepOver";
    "when" = "debugState == 'stopped'";
  }
  {
    "key" = "f11";
    "command" = "workbench.action.debug.stepInto";
    "when" = "debugState != 'inactive'";
  }
  {
    "key" = "shift+f11";
    "command" = "workbench.action.debug.stepOut";
    "when" = "debugState == 'stopped'";
  }
  {
    "key" = "";
    "command" = "editor.debug.action.runToCursor";
    "when" = "debugState == 'stopped'";
  }
  {
    "key" = "shift+cmd+y";
    "command" = "workbench.debug.action.toggleRepl";
    "when" = "debuggersAvailable";
  }
  {
    "key" = "";
    "command" = "editor.debug.action.selectionToRepl";
    "when" = "debuggersAvailable && editorTextFocus && editorHasSelection";
  }
  {
    "key" = "f5";
    "command" = "workbench.action.debug.continue";
    "when" = "inDebugMode";
  }
  {
    "key" = "f9";
    "command" = "editor.debug.action.toggleBreakpoint";
    "when" = "debuggersAvailable && editorTextFocus";
  }
  {
    "key" = "cmd+shift+f8";
    "command" = "workbench.debug.action.focusBreakpointsView";
  }
  {
    "key" = "cmd+t";
    "command" = "workbench.action.showAllSymbols";
  }
  {
    "key" = "cmd+p";
    "command" = "workbench.action.quickOpen";
  }
  {
    "key" = "shift+cmd+o";
    "command" = "workbench.action.gotoSymbol";
    "when" = "editorTextFocus";
  }
  {
    "key" = "shift+cmd+[";
    "command" = "workbench.action.previousEditor";
  }
  {
    "key" = "alt+cmd+left";
    "command" = "workbench.action.previousEditor";
  }
  {
    "key" = "shift+cmd+]";
    "command" = "workbench.action.nextEditor";
  }
  {
    "key" = "alt+cmd+right";
    "command" = "workbench.action.nextEditor";
  }
  {
    "key" = "cmd+b";
    "command" = "workbench.action.toggleSidebarVisibility";
    "when" = "!editorFocus && !terminalFocus && !problemFocus && !inDebugRepl";
  }
  {
    "key" = "shift+cmd+m";
    "command" = "workbench.actions.view.problems";
  }
  {
    "key" = "ctrl+`";
    "command" = "workbench.action.terminal.toggleTerminal";
  }
  {
    "key" = "ctrl+g";
    "command" = "workbench.action.gotoLine";
  }
  {
    "key" = "";
    "command" = "workbench.action.openPreviousEditorFromHistory";
    "when" = "inQuickOpen";
  }
  {
    "key" = "cmd+e";
    "command" = "workbench.action.openRecent";
    "when" = "!inQuickOpen";
  }
  {
    "key" = "ctrl+-";
    "command" = "workbench.action.navigateBack";
    "when" = "canNavigateBack";
  }
  {
    "key" = "ctrl+shift+-";
    "command" = "workbench.action.navigateForward";
    "when" = "canNavigateForward";
  }
  {
    "key" = "cmd+k cmd+q";
    "command" = "workbench.action.navigateToLastEditLocation";
  }
  {
    "key" = "";
    "command" = "editor.action.goToDeclaration";
    "when" = "editorTextFocus";
  }
  {
    "key" = "cmd+f12";
    "command" = "editor.action.goToImplementation";
    "when" = "editorHasImplementationProvider && editorTextFocus && !isInEmbeddedEditor";
  }
  {
    "key" = "";
    "command" = "editor.action.previewDeclaration";
  }
  {
    "key" = "";
    "command" = "editor.action.goToTypeDefinition";
    "when" = "editorTextFocus";
  }
  {
    "key" = "";
    "command" = "outline.focus";
  }
  {
    "key" = "shift+cmd+o";
    "command" = "workbench.action.gotoSymbol";
    "when" = "editorTextFocus";
  }
  {
    "key" = "alt+f8";
    "command" = "editor.action.marker.next";
    "when" = "editorFocus";
  }
  {
    "key" = "shift+alt+f8";
    "command" = "editor.action.marker.prev";
    "when" = "editorFocus";
  }
  {
    "key" = "alt+f3";
    "command" = "editor.action.dirtydiff.next";
    "when" = "editorTextFocus";
  }
  {
    "key" = "shift+alt+f3";
    "command" = "editor.action.dirtydiff.previous";
    "when" = "editorTextFocus";
  }
  {
    "key" = "cmd+up";
    "command" = "cursorTop";
    "when" = "textInputFocus";
  }
  {
    "key" = "cmd+down";
    "command" = "cursorBottom";
    "when" = "textInputFocus";
  }
  {
    "key" = "f2";
    "command" = "editor.action.rename";
    "when" = "editorHasRenameProvider && editorTextFocus && !editorReadonly";
  }
  {
    "key" = "cmd+f2";
    "command" = "editor.action.changeAll";
    "when" = "editorTextFocus && editorTextFocus && !editorReadonly";
  }
  {
    "key" = "enter";
    "command" = "renameFile";
    "when" = "explorerViewletVisible && filesExplorerFocus";
  }
  {
    "key" = "";
    "command" = "git.commitAll";
    "when" = "!inDebugMode && !terminalFocus";
  }
  {
    "key" = "";
    "command" = "git.pushTo";
    "when" = "!inDebugMode && !terminalFocus";
  }
  {
    "key" = "";
    "command" = "git.sync";
  }
  {
    "key" = "cmd+k cmd+r";
    "command" = "git.revertSelectedRanges";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "shift+cmd+m";
    "command" = "workbench.actions.view.problems";
  }
  {
    "key" = "shift+cmd+e";
    "command" = "workbench.view.explorer";
    "when" = "!explorerViewletFocus";
  }
  {
    "key" = "cmd+b";
    "command" = "workbench.action.toggleSidebarVisibility";
    "when" = "explorerViewletFocus";
  }
  {
    "key" = "cmd+b";
    "command" = "workbench.action.toggleSidebarVisibility";
  }
  {
    "key" = "ctrl+shift+g";
    "command" = "workbench.view.scm";
    "when" = "activeViewlet != 'workbench.view.scm'";
  }
  {
    "key" = "alt+cmd+s";
    "command" = "workbench.action.files.saveAll";
  }
  {
    "key" = "ctrl+cmd+f";
    "command" = "workbench.action.toggleFullScreen";
  }
  {
    "key" = "";
    "command" = "workbench.action.maximizeEditor";
  }
  {
    "key" = "cmd+k cmd+t";
    "command" = "workbench.action.selectTheme";
  }
  {
    "key" = "";
    "command" = "workbench.action.openGlobalSettings";
  }
  {
    "key" = "";
    "command" = "workbench.action.tasks.configureTaskRunner";
  }
  {
    "key" = "f1";
    "command" = "workbench.action.showCommands";
  }
  {
    "key" = "shift+cmd+p";
    "command" = "workbench.action.showCommands";
  }
  {
    "key" = "";
    "command" = "workbench.action.quickOpenNavigateNext";
    "when" = "inQuickOpen";
  }
  {
    "key" = "alt+f5";
    "command" = "workbench.action.compareEditor.nextChange";
    "when" = "textCompareEditorVisible";
  }
  {
    "key" = "shift+alt+f5";
    "command" = "workbench.action.compareEditor.previousChange";
    "when" = "textCompareEditorVisible";
  }
  {
    "key" = "shift+cmd+enter";
    "command" = "editor.action.insertLineBefore";
    "when" = "editorTextFocus && !editorReadonly";
  }
  {
    "key" = "cmd+enter";
    "command" = "editor.action.insertLineAfter";
    "when" = "editorTextFocus && !editorReadonly && !suggestWidgetVisible";
  }
  {
    "key" = "";
    "command" = "workbench.action.terminal.focus";
    "when" = "!terminalFocus";
  }
  {
    "key" = "ctrl+`";
    "command" = "workbench.action.terminal.toggleTerminal";
    "when" = "terminalFocus";
  }
  {
    "key" = "shift+cmd+l";
    "command" = "editor.action.selectHighlights";
    "when" = "editorFocus";
  }
  {
    "key" = "";
    "command" = "workbench.action.terminal.focusPrevious";
    "when" = "terminalFocus";
  }
  {
    "key" = "";
    "command" = "workbench.action.terminal.focusNext";
    "when" = "terminalFocus";
  }
  {
    "key" = "";
    "command" = "workbench.action.focusNextGroup";
    "when" = "editorFocus";
  }
  {
    "key" = "";
    "command" = "workbench.action.focusPreviousGroup";
    "when" = "editorFocus";
  }
  {
    "key" = "cmd+down";
    "command" = "list.select";
    "when" = "filesExplorerFocus && foldersViewVisible && !explorerResourceIsFolder && !inputFocus";
  }
  {
    "key" = "enter";
    "command" = "list.select";
    "when" = "filesExplorerFocus && foldersViewVisible && !explorerResourceIsFolder && !inputFocus";
  }
  {
    "key" = "shift+cmd+;";
    "command" = "breadcrumbs.focusAndSelect";
    "when" = "breadcrumbsPossible && breadcrumbsVisible";
  }
  {
    "key" = "alt+cmd+c";
    "command" = "copyFilePath";
    "when" = "!editorFocus && !terminalFocus";
  }
  {
    "key" = "cmd+i";
    "command" = "editor.action.triggerSuggest";
    "when" = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly";
  }
  {
    "key" = "alt+escape";
    "command" = "editor.action.triggerSuggest";
    "when" = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly";
  }
  {
    "key" = "ctrl+space";
    "command" = "editor.action.triggerSuggest";
    "when" = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly";
  }
  {
    "key" = "shift+cmd+f";
    "command" = "workbench.action.findInFiles";
    "when" = "!explorerResourceIsFolder || !filesExplorerFocus";
  }
  {
    "key" = "cmd+c";
    "command" = "editor.action.clipboardCopyAction";
  }
  {
    "key" = "cmd+v";
    "command" = "editor.action.clipboardPasteAction";
  }
  {
    "key" = "shift+cmd+z";
    "command" = "redo";
  }
  {
    "key" = "cmd+z";
    "command" = "undo";
  }
  {
    "key" = "";
    "command" = "compareFiles";
  }
  {
    "key" = "";
    "command" = "merge-conflict.accept.current";
    "when" = "isInDiffEditor";
  }
  {
    "key" = "";
    "command" = "merge-conflict.accept.incoming";
    "when" = "isInDiffEditor";
  }
  {
    "key" = "";
    "command" = "git.openChange";
  }
  {
    "key" = "cmd+k o";
    "command" = "workbench.action.files.showOpenedFileInNewWindow";
    "when" = "emptyWorkspaceSupport";
  }
  {
    "key" = "ctrl+e";
    "command" = "cursorLineEnd";
    "when" = "textInputFocus";
  }
  {
    "key" = "ctrl+shift+e";
    "command" = "cursorLineEndSelect";
    "when" = "textInputFocus";
  }
  {
    "key" = "ctrl+a";
    "command" = "cursorLineStart";
    "when" = "textInputFocus";
  }
  {
    "key" = "ctrl+shift+a";
    "command" = "cursorLineStartSelect";
    "when" = "textInputFocus";
  }
  {
    "key" = "cmd+down";
    "command" = "cursorBottom";
    "when" = "textInputFocus";
  }
  {
    "key" = "cmd+up";
    "command" = "cursorTop";
    "when" = "textInputFocus";
  }
  {
    "key" = "shift+cmd+down";
    "command" = "cursorBottomSelect";
    "when" = "textInputFocus";
  }
  {
    "key" = "shift+cmd+up";
    "command" = "cursorTopSelect";
    "when" = "textInputFocus";
  }
  {
    "key" = "pagedown";
    "command" = "cursorPageDown";
    "when" = "textInputFocus";
  }
  {
    "key" = "shift+pagedown";
    "command" = "cursorPageDownSelect";
    "when" = "textInputFocus";
  }
  {
    "key" = "pageup";
    "command" = "cursorPageUp";
    "when" = "textInputFocus";
  }
  {
    "key" = "shift+pageup";
    "command" = "cursorPageUpSelect";
    "when" = "textInputFocus";
  }
  {
    "key" = "shift+alt+h";
    "command" = "references-view.showCallHierarchy";
    "when" = "editorHasCallHierarchyProvider";
  }
  {
    "key" = "shift+alt+o";
    "command" = "editor.action.organizeImports";
    "when" = "editorTextFocus && !editorReadonly && supportedCodeAction =~ /(\\s|^)source\\.organizeImports\\b/";
  }
  {
    "key" = "";
    "command" = "java.action.showTypeHierarchy";
    "when" = "editorLangId == java && javaLSReady && editorTextFocus";
  }

  {
    "key" = "shift+k";
    "command" = "editor.action.showDefinitionPreviewHover";
    "when" = "editorTextFocus && vim.mode == 'Normal'";
  }
  {
    "key" = "ctrl+right";
    "command" = "cursorWordRight";
  }
  {
    "key" = "ctrl+left";
    "command" = "cursorWordLeft";
  }
  {
    "key" = "ctrl+right";
    "command" = "paredit.forwardSexp";
    "when" = "calva =keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit =keyMap =~ /original|strict/";
  }
  {
    "key" = "ctrl+left";
    "command" = "paredit.backwardSexp";
    "when" = "calva =keybindingsEnabled && editorTextFocus && editorLangId == 'clojure' && paredit =keyMap =~ /original|strict/";
  }
  {
    "key" = "shift+9";
    "command" = "paredit.wrapAroundParens";
    "when" = "editorTextFocus && editorHasSelection && !editorReadOnly && editorLangId =~ /clojure|scheme|lisp/ && paredit =keyMap =~ /original|strict/";
  }
  {
    "key" = "[";
    "command" = "paredit.wrapAroundSquare";
    "when" = "editorHasSelection && editorTextFocus && !editorReadOnly && editorLangId =~ /clojure|scheme|lisp/ && paredit =keyMap =~ /original|strict/";
  }
  {
    "key" = "shift+[";
    "command" = "paredit.wrapAroundCurly";
    "when" = "editorHasSelection && editorTextFocus && !editorReadOnly && editorLangId =~ /clojure|scheme|lisp/ && paredit =keyMap =~ /original|strict/";
  }
  {
    "key" = "escape";
    "command" = "-calva.clearInlineResults";
  }
  {
    "key" = "shift+escape";
    "command" = "calva.clearInlineResults";
    "when" = "editorTextFocus && !editorHasMultipleSelections && !editorReadOnly && !hasOtherSuggestions && !suggestWidgetVisible && editorLangId == 'clojure'";
  }
  {
    "key" = "alt+cmd+k";
    "command" = "-git.pushTo";
    "when" = "!inDebugMode && !operationInProgress && !terminalFocus";
  }
  {
    "key" = "alt+cmd+k";
    "command" = "-bookmarks.toggle";
    "when" = "editorTextFocus";
  }
  {
    "key" = "alt+cmd+k";
    "command" = "bookmarks.toggleLabeled";
  }
  {
    "key" = "shift+cmd+x";
    "command" = "-workbench.view.extensions";
    "when" = "viewContainer.workbench.view.extensions.enabled";
  }
  {
    "key" = "cmd+1";
    "command" = "-workbench.action.focusFirstEditorGroup";
  }
  {
    "key" = "cmd+1";
    "command" = "workbench.view.explorer";
    "when" = "viewContainer.workbench.view.explorer.enabled";
  }
  {
    "key" = "cmd+2";
    "command" = "-workbench.action.focusSecondEditorGroup";
  }
  {
    "key" = "cmd+2";
    "command" = "workbench.view.search";
  }
  {
    "key" = "cmd+3";
    "command" = "workbench.view.extensions";
    "when" = "viewContainer.workbench.view.extensions.enabled";
  }
  {
    "key" = "cmd+3";
    "command" = "-workbench.action.toggleSidebarVisibility";
    "when" = "searchViewletVisible";
  }
  {
    "key" = "cmd+numpad3";
    "command" = "-workbench.action.toggleSidebarVisibility";
    "when" = "searchViewletVisible";
  }
  {
    "key" = "cmd+5";
    "command" = "workbench.view.scm";
    "when" = "workbench.scm.active && activeViewlet != 'workbench.view.scm'";
  }
  {
    "key" = "cmd+numpad9";
    "command" = "-workbench.view.scm";
    "when" = "workbench.scm.active && activeViewlet != 'workbench.view.scm'";
  }
  {
    "key" = "cmd+9";
    "command" = "-workbench.view.scm";
    "when" = "workbench.scm.active && activeViewlet != 'workbench.view.scm'";
  }
  {
    "key" = "cmd+4";
    "command" = "workbench.view.debug";
    "when" = "viewContainer.workbench.view.debug.enabled && activeViewlet != 'workbench.view.debug'";
  }
  {
    "key" = "cmd+5";
    "command" = "-workbench.view.debug";
    "when" = "viewContainer.workbench.view.debug.enabled && activeViewlet != 'workbench.view.debug'";
  }
  {
    "key" = "shift+cmd+f";
    "command" = "-workbench.view.search";
    "when" = "workbench.view.search.active && neverMatch =~ /doesNotMatch/";
  }
  {
    "key" = "cmd+6";
    "command" = "workbench.view.extension.bookmarks";
  }
  {
    "key" = "cmd+h";
    "command" = "workbench.action.toggleActivityBarVisibility";
  }
  {
    "key" = "alt+g";
    "command" = "extension.vim_ctrl+g";
    "when" = "editorTextFocus && vim.active && vim.use<C-g> && !inDebugRepl";
  }
  {
    "key" = "cmd+n";
    "command" = "-editor.action.sourceAction";
    "when" = "editorHasCodeActionsProvider && editorTextFocus && !editorReadonly";
  }
  {
    "key" = "shift+;";
    "command" = "vim.showQuickpickCmdLine";
    "when" = "editorTextFocus && vim.mode != 'Insert'";
  }
  {
    "key" = "escape";
    "command" = "extension.vim_escape";
    "when" = "editorTextFocus && vim.active && !inDebugRepl && !parameterHintsVisible && !suggestWidgetVisible";
  }
  {
    "key" = "escape";
    "command" = "-extension.vim_escape";
    "when" = "editorTextFocus && vim.active && !inDebugRepl";
  }
  {
    "key" = "shift+tab";
    "command" = "-extension.vim_shift+tab";
    "when" = "editorTextFocus && vim.active && !inDebugRepl && vim.mode != 'Insert'";
  }
  {
    "key" = "tab";
    "command" = "-extension.vim_tab";
    "when" = "editorTextFocus && vim.active && !inDebugRepl && vim.mode != 'Insert'";
  }
  {
    "key" = "cmd+b";
    "command" = "bookmarks.list";
  }
  {
    "key" = "shift+cmd+b";
    "command" = "-workbench.action.tasks.build";
    "when" = "taskCommandsRegistered";
  }
  {
    "key" = "shift+cmd+b";
    "command" = "bookmarks.listFromAllFiles";
  }
  {
    "key" = "cmd+b";
    "command" = "-editor.action.goToDeclaration";
    "when" = "editorTextFocus";
  }
  {
    "key" = "cmd+p";
    "command" = "-workbench.action.quickOpen";
  }
  {
    "key" = "shift+cmd+o";
    "command" = "-workbench.action.quickOpen";
  }
  {
    "key" = "cmd+e";
    "command" = "-workbench.action.quickOpen";
    "when" = "!inQuickOpen";
  }
  {
    "key" = "shift+cmd+a";
    "command" = "-workbench.action.showCommands";
  }
  {
    "key" = "ctrl+o";
    "command" = "workbench.action.navigateBack";
    "when" = "canNavigateBack";
  }
  {
    "key" = "ctrl+i";
    "command" = "workbench.action.navigateForward";
    "when" = "canNavigateForward";
  }
  {
    "key" = "ctrl+i";
    "command" = "-editor.action.triggerSuggest";
  }
  {
    "key" = "shift+cmd+s";
    "command" = "workbench.action.files.saveWithoutFormatting";
  }
]
