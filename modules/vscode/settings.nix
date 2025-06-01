# SECTION = General
#   Current vscode configuration for Gabrielle GuimarÃ£es de Oliveira,
#   it does configure the window, rust, haskell, and some other extensions.
#   The configuration is divided in sections, subsections and subsubsections.
{
  # SECTION = Window
  #   SUBSECTION = Command Center
  "window.commandCenter" = true;
  "window.customTitleBarVisibility" = true;

  # SECTION = Security
  "security.workspace.trust.untrustedFiles" = "open";

  # SECTION = Git
  "git.enableSmartCommit" = true;
  "git.autofetch" = false;
  "git.confirmSync" = false;

  # SECTION = Editor configuration
  #   SUBSECTION = Font
  "editor.fontSize" = 18;
  "editor.fontLigatures" = "'ss01', 'cv03', 'zero'";
  "editor.fontFamily" = "JetBrains Mono";
  "editor.wordWrap" = "off";
  #   SUBSECTION = Suggests
  #   Disable the word suggestions, because I don't like them.
  "editor.suggest.showWords" = false;
  #   SUBSECTION = Formatting
  "editor.formatOnPaste" = true;
  #     Format on save, false, for now, because, if I need to save a file
  #     without formatting, it's boring to have to press Ctrl+Shift+S
  #     instead of just saving it.
  "editor.formatOnSave" = true;
  "editor.rulers" = [80 100 120 160]; # Rulers at 80, 100, 120, 160
  #   SUBSECTION = Highlight
  "editor.bracketPairColorization.enabled" = true;
  "editor.guides.bracketPairs" = true;
  "editor.inlineSuggest.enabled" = true;
  "editor.semanticHighlighting.enabled" = true;
  "editor.wordSeparators" = "`~!@#$%^&*()-=+[{]}\\|;:'\",.<>/?";
  "editor.cursorSmoothCaretAnimation" = "on";
  #   SUBSECTION = Auto close
  "editor.autoClosingDelete" = "always";
  "editor.autoClosingQuotes" = "always";
  "editor.autoClosingBrackets" = "always";
  #   SUBSECTION = Numbers
  "editor.tabSize" = 2;
  "editor.linkedEditing" = true;
  "editor.suggestSelection" = "first";
  "editor.lineNumbers" = "relative";
  #   SUBSECTION = Inlay Hints
  "editor.inlayHints.enabled" = "offUnlessPressed";

  # SECTION = Search
  "search.quickOpen.includeSymbols" = true;
  "search.quickOpen.includeHistory" = true;

  "editor.minimap.enabled" = false;

  # SECTION = Terminal
  #   SUBSECTION = Font
  #   I use JetBrains Mono, but I also like to use FiraCode Nerd Font
  "terminal.integrated.fontFamily" = "JetBrains Mono";
  "terminal.integrated.fontSize" = 18;

  # SECTION = Haskell
  #   SUBSECTION = Go to Definition
  "haskell.openSourceInHackage" = true;
  "haskell.openDocumentationInHackage" = true;
  #   SUBSECTION = Language Server
  "haskell.manageHLS" = "GHCup";
  "haskell.plugin.ghcide-type-lenses.config.mode" = "diagnostics";
  #   SUBSECTION = HLint
  "haskell.formattingProvider" = "fourmolu";

  # SECTION = OCaml
  "ocaml.server.codelens" = true;

  # SECTION = Calva
  "calva.highlight.rainbowIndentGuides" = true;
  "calva.showDocstringInParameterHelp" = true;
  "calva.paredit.defaultKeyMap" = "strict";
  "calva.fmt.configPath" = "/Users/Gabrielle/.cljfmt.edn";
  "calva.prettyPrintingOptions" = {
    "printEngine" = "pprint";
    "enabled" = true;
    "width" = 120;
    "maxLength" = 50;
  };

  # SECTION = JavaScript
  "javascript.updateImportsOnFileMove.enabled" = "always";
  "typescript.updateImportsOnFileMove.enabled" = "always";
  #   SUBSECTION = ESLint
  "eslint.format.enable" = true;
  #   SUBSECTION = Prettier
  #     SUBSECTION = End of line
  "prettier.endOfLine" = "lf";
  "prettier.semi" = true;
  #     SUBSECTION = Width
  "prettier.tabWidth" = 2;
  "prettier.printWidth" = 80;
  #     SUBSECTION = Comma
  "prettier.trailingComma" = "all";
  "prettier.requirePragma" = false;
  "prettier.embeddedLanguageFormatting" = "auto";
  #     SUBSECTION = Brackets and parens
  "prettier.bracketSpacing" = false;
  "prettier.arrowParens" = "always";
  #     SUBSECTION = Quotes
  "prettier.singleQuote" = true;
  "prettier.jsxSingleQuote" = true;
  "prettier.quoteProps" = "consistent";

  # SECTION = Calva
  "calva.useTestExplorer" = true;

  # SECTION = Rust analyzer
  "rust-analyzer.checkOnSave" = true;
  "rust-analyzer.check.command" = "clippy";
  "rust-analyzer.check.allTargets" = true;
  "rust-analyzer.cachePriming.enable" = true;
  #   SUBSECTION = Completion
  "rust-analyzer.completion.fullFunctionSignatures.enable" = true;
  #   SUBSECTION = Inlay hints
  "rust-analyzer.inlayHints.parameterHints.enable" = false;
  "rust-analyzer.inlayHints.typeHints.enable" = false;
  "rust-analyzer.inlayHints.chainingHints.enable" = true;
  "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "always";
  "rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames" = true;
  #   SUBSECTION = Assists
  "rust-analyzer.assist.emitMustUse" = true;
  "rust-analyzer.assist.termSearch.enable" = true;
  "rust-analyzer.assist.expressionFillDefault" = "default";
  #   SUBSECTION = Debugger
  "rust-analyzer.debug.engine" = "vadimcn.vscode-lldb";
  #   SUBSECTION = Highlight
  "rust-analyzer.semanticHighlighting.operator.specialization.enable" = true;
  "rust-analyzer.highlightRelated.breakPoints.enable" = true;
  #   SUBSECTION = Code Actions
  #   Enable all code actions for Rust Analyzer, because I want to see
  #   all the possible actions.
  "rust-analyzer.hover.actions.enable" = true;
  "rust-analyzer.hover.actions.debug.enable" = true;
  "rust-analyzer.hover.actions.gotoTypeDef.enable" = true;
  "rust-analyzer.hover.actions.implementations.enable" = true;
  "rust-analyzer.hover.actions.run.enable" = true;
  "rust-analyzer.lens.references.adt.enable" = false;
  "rust-analyzer.lens.implementations.enable" = false;
  "rust-analyzer.lens.references.trait.enable" = false;
  "rust-analyzer.lens.references.method.enable" = false;
  #   SUBSECTION = Debug
  "rust-analyzer.debug.openDebugPane" = true;
  "rust-analyzer.cargo.features" = [];

  # SECTION = Debug
  #   SUBSECTION = UI
  "debug.showInStatusBar" = "always";
  "debug.toolBarLocation" = "docked";
  #   SUBSECTION = Values
  "debug.inlineValues" = "on";
  "debug.disassemblyView.showSourceCode" = true;
  #   SUBSECTION = Save
  #   Save all files before debugging, so that I don't have to save them
  #   manually before debugging
  "debug.saveBeforeStart" = "allEditorsInActiveGroup";

  # SECTION = LiveShare
  # Pair programming with other people. It allows you to share your
  # workspace with other people, and they can edit your code, and you
  # can edit theirs.
  "liveshare.languages.allowGuestCommandControl" = true;
  "liveshare.allowGuestDebugControl" = true;
  "liveshare.allowGuestTaskControl" = true;
  "liveshare.publishWorkspaceInfo" = true;

  # SECTION = Breadcumbs
  "breadcrumbs.enabled" = true;
  "breadcrumbs.showArrays" = true;
  "breadcrumbs.showVariables" = true;
  "breadcrumbs.showBooleans" = true;
  "breadcrumbs.showClasses" = true;
  "breadcrumbs.showConstants" = true;
  "breadcrumbs.showConstructors" = true;
  "breadcrumbs.showEnumMembers" = true;
  "breadcrumbs.showEnums" = true;
  "breadcrumbs.showEvents" = true;
  "breadcrumbs.showFields" = true;
  "breadcrumbs.showFiles" = true;
  "breadcrumbs.showFunctions" = true;
  "breadcrumbs.showInterfaces" = true;
  "breadcrumbs.showMethods" = true;

  "errorLens.enabledDiagnosticLevels" = ["error" "warning" "info" "hint"];

  # SECTION = Explorer
  "explorer.compactFolders" = false;
  "explorer.confirmDelete" = false;
  "explorer.confirmDragAndDrop" = false;
  "explorer.fileNesting.enabled" = false;

  "redhat.telemetry.enabled" = false;

  # SECTION = File associations, and exclude
  "files.eol" = "\n";
  "files.autoSave" = "off";
  "files.associations" = {
    ".huskyrc" = "json";
    "*.json" = "jsonc";
    "*.uidx" = "jsonc";
  };
  #   SUBSECTION = Associations
  "files.exclude" = {
    #   SUBSECTION = Node.js
    "**/node_modules" = true;
    "**/.next" = true;
    #   SUBSECTION = SCM
    "**/.git" = true;
    "**/.svn" = true;
    #   SUBSECTION = Purescript, Rescript, etc
    "**/.spago" = true;
    "**/*.bs.js" = true;
    #   SUBSECTION = Java
    "**/.gradle" = true;
    "**/.classpath" = true;
    "**/.settings" = true;
    "**/.project" = true;
    #   SUBSECTION = Mac OS
    "**/.DS_Store" = true;
    #   SUBSECTION = Others
    "**/*.ibc" = true;
    "**/.factorypath" = true;
    "**/.hg" = true;
    "**/CVS" = true;
  };

  # SECTION = Languages
  "[rust]" = {
    "editor.tabSize" = 4;
    "editor.useTabStops" = true;
    "editor.rulers" = [100];
  };
  "[cpp]" = {
    "editor.defaultFormatter" = "xaver.clang-format";
  };
  "[csharp]" = {
    "editor.tabSize" = 4;
  };
  #   SUBSECTION = Configuration Languages
  #   Usually to set the default formatter
  "[haskell]" = {
    # Sets the default formatter to the LSP
    "editor.defaultFormatter" = "haskell.haskell";
  };
  "[c]" = {
    "editor.defaultFormatter" = "xaver.clang-format";
  };
  "[yaml]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[jsonc]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[json]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  #   SUBSECTION = Typescript and Javascript
  "[typescriptreact]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[typescript]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[javascript]" = {
    "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
    # Disable ESLint on save
    # "editor.codeActionsOnSave" = {
    #   "source.fixAll.eslint" = false
    # }
  };
  #  SUBSECTION = HTML
  "[html]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[css]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  #  SUBSECTION = Clojure
  "[clojure]" = {
    "editor.autoClosingBrackets" = "always";
    "editor.autoClosingOvertype" = "always";
    "editor.formatOnPaste" = true;
  };

  # SECTION = VIM
  "vim.leader" = "<space>";
  #   SUBSECTION = General
  "vim.incsearch" = true;
  "vim.hlsearch" = true;
  "vim.visualstar" = true;
  "vim.targets.enable" = true;
  "vim.camelCaseMotion.enable" = true;
  "vim.iskeyword" = "`~!@#$%^&*()-=+[{]}\\|;:'\",.<>/?";
  "vim.useSystemClipboard" = true;
  "vim.useCtrlKeys" = true;
  "vim.matchpairs" = "(:),{:},[:]";
  "vim.showMarksInGutter" = true;
  "vim.handleKeys" = {
    "<C-y>" = false;
    "<C-f>" = false;
    "<C-o>" = false;
    "<C-i>" = false;
  };
  "vim.foldfix" = true;
  "vim.highlightedyank.enable" = true;
  "vim.surround" = true;
  "vim.sneak" = true;
  #   SUBSECTION = Keybindings
  "vim.operatorPendingModeKeyBindingsNonRecursive" = [
    {
      "before" = ["("];
      "after" = ["i("];
    }
    {
      "before" = ["{"];
      "after" = ["w"];
    }
    {
      "before" = ["L"];
      "after" = ["$"];
    }
    {
      "before" = ["H"];
      "after" = ["^"];
    }
  ];
  "vim.visualModeKeyBindings" = [
    {
      "before" = ["g" "p"];
      "commands" = ["editor.action.peekDefinition"];
    }
    {
      "before" = ["g" "d"];
      "commands" = ["editor.action.revealDefinition"];
    }
    #   SUBSECTION = Surround
    {
      "before" = ["p"];
      "after" = ["p" "g" "v" "y"];
    }
    #   SUBSECTION = Indent
    #   Use < and > to indent/unindent
    {
      "before" = [">"];
      "commands" = ["editor.action.indentLines"];
    }
    {
      "before" = ["<"];
      "commands" = ["editor.action.outdentLines"];
    }
  ];
  "vim.normalModeKeyBindingsNonRecursive" = [
    {
      "before" = ["g" "p"];
      "commands" = ["editor.action.peekDefinition"];
    }
    {
      "before" = ["g" "d"];
      "commands" = ["editor.action.revealDefinition"];
    }
    {
      "before" = ["h"];
      "commands" = ["cursorLeft"];
    }
    {
      "before" = ["j"];
      "commands" = ["cursorDown"];
    }
    {
      "before" = ["k"];
      "commands" = ["cursorUp"];
    }
    {
      "before" = ["l"];
      "commands" = ["cursorRight"];
    }
    {
      "before" = ["K"];
      "commands" = ["lineBreakInsert"];
      "silent" = true;
    }
    {
      "before" = [":"];
      "commands" = ["workbench.action.showCommands"];
      "silent" = true;
    }
  ];
  "vim.normalModeKeyBindings" = [
    {
      "before" = ["<C-n>"];
      "commands" = [":nohl"];
    }
    #   SUBSECTION = Find shortcuts
    #   Use ctrl-f to find
    {
      # Enable the default vscode find
      "before" = ["<C-f>"];
      "commands" = ["actions.find"];
    }
    {
      "before" = ["/"];
      "commands" = ["actions.find"];
    }
    {
      "before" = ["<leader>" "b"];
      "commands" = ["editor.debug.action.toggleBreakpoint"];
    }
    #   SUBSECTION = Debug and breakpoints
    #   Use <leader>b to toggle breakpoints
    {
      "before" = ["<leader>" "b"];
      "commands" = ["editor.debug.action.toggleBreakpoint"];
    }
    #   SUBSECTION = Cargo check
    #   Use <leader>cc to toggle breakpoints
    {
      "before" = ["<leader>" "c" "c"];
      "commands" = ["cargo.check"];
    }
  ];
  "vim.insertModeKeyBindings" = [
    #   SUBSECTION = Calva bindings
    #   It's useful to have these bindings, because I use Calva to
    #   code clojure
    {
      "before" = ["j" "k"];
      "after" = ["<esc>"];
    }
  ];
  "vim.autoSwitchInputMethod.enable" = true;
  "vim.autoSwitchInputMethod.defaultIM" = "com.apple.keylayout.US";
  "vim.autoSwitchInputMethod.obtainIMCmd" = "/usr/local/bin/im-select";
  "vim.autoSwitchInputMethod.switchIMCmd" = "/usr/local/bin/im-select {im}";

  # SECTION = Workbench
  # Setups the workbench and the visual appearance of vscode
  "workbench.layoutControl.enabled" = false;
  "workbench.list.smoothScrolling" = true;
  "workbench.statusBar.visible" = false;
  "workbench.tree.indent" = 10;
  "workbench.tree.expandMode" = "doubleClick";
  "workbench.sideBar.location" = "right";
  "workbench.layoutControl.type" = "both";
  "workbench.editor.enablePreview" = false;
  "workbench.activityBar.location" = "hidden";
  "workbench.editor.labelFormat" = "medium";
  "workbench.editor.splitInGroupLayout" = "horizontal";
  #   SUBSECTION = Command
  #   Preserve input in the command palette between sessions
  "workbench.commandPalette.preserveInput" = true;
  "workbench.tree.renderIndentGuides" = "onHover";
  #   SUBSECTION = Themes
  "workbench.editor.highlightModifiedTabs" = true;
  #   SUBSECTION = Search
  "workbench.editor.enablePreviewFromQuickOpen" = true;
  "workbench.commandPalette.experimental.suggestCommands" = true;
  "workbench.commandPalette.experimental.askChatLocation" = "quickChat";
  "workbench.commandPalette.experimental.enableNaturalLanguageSearch" = true;
  "workbench.quickOpen.preserveInput" = true;
  #  SUBSECTION = Themes
  "window.autoDetectColorScheme" = true;
  "workbench.preferredLightColorTheme" = "GitHub Light Default";
  "workbench.preferredDarkColorTheme" = "GitHub Dark Colorblind (Beta)";
  #   SUBSECTION = UI-Selected themes
  "workbench.iconTheme" = "vscode-jetbrains-icon-theme-2023-auto";
  "workbench.colorTheme" = "GitHub Dark Default";
  "vscode-edge-devtools.webhintInstallNotification" = true;
  "update.mode" = "manual";
  "search.quickAccess.preserveInput" = true;

  "remote.SSH.enableAgentForwarding" = true;
  "remote.SSH.permitPtyAllocation" = true;
}
