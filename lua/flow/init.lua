local M = {}
local palette = require("flow.palettes").palette

M.options = {
    transparent_background = false,
    term_colors = true,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
        parameters = { "italic" },
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        indent_blankline = true,
        native_lsp = true,
        nvim_dap = true,
        lsp_trouble = true,
        which_key = true,
        bufferline = true,
        notify = true,
        noice = true,
        dressing = true,
        flash = true,
        snacks = true,
    },
    features = {
        illuminate = {
            enabled = true,
            background_only = false,
        },
        dim_inactive = {
            enabled = false,
            percentage = 0.15,
        },
        indent_guides = {
            enabled = true,
            colored_indent_levels = false,
        },
    },
}

-- Setup function with more options
function M.setup(options)
    M.options = vim.tbl_deep_extend("force", M.options, options or {})
end

-- Apply highlight groups with enhanced functionality
local function apply_highlights()
    local highlights = {
        -- Editor - Set backgrounds to nil for transparency
        Normal = { fg = palette.bright_foreground, bg = nil },
        NormalFloat = { fg = palette.bright_foreground, bg = nil },
        FloatBorder = { fg = palette.border, bg = nil },
        FloatTitle = { fg = palette.bright_blue, bold = true },
        Cursor = { fg = palette.background, bg = palette.bright_foreground },
        CursorLine = {}, -- Disabled to prevent line highlight
        CursorLineNr = {}, -- Disabled to prevent line number highlight
        LineNr = { fg = palette.light_gray, bg = nil },
        SignColumn = { bg = nil },
        ColorColumn = { bg = nil }, -- Remove background
        VertSplit = { fg = palette.border, bg = nil },
        WinSeparator = { fg = palette.border, bg = nil },
        Visual = { fg = palette.selection_fg, bg = palette.selection_bg },
        VisualNOS = { fg = palette.selection_fg, bg = palette.selection_bg },
        Search = { fg = palette.background, bg = palette.bright_blue },
        IncSearch = { fg = palette.background, bg = palette.bright_yellow },
        CurSearch = { fg = palette.background, bg = palette.bright_purple },
        Pmenu = { fg = palette.bright_foreground, bg = nil },
        PmenuSel = { fg = palette.bright_foreground, bg = palette.element_active, bold = true },
        PmenuSbar = { bg = nil },
        PmenuThumb = { bg = palette.gray },
        StatusLine = { fg = palette.bright_foreground, bg = nil },
        StatusLineNC = { fg = palette.light_gray, bg = nil },
        WildMenu = { fg = palette.bright_foreground, bg = palette.element_active },
        WinBar = { fg = palette.bright_foreground, bg = nil },
        WinBarNC = { fg = palette.light_gray, bg = nil },
        TabLine = { fg = palette.light_gray, bg = nil },
        TabLineFill = { bg = nil },
        TabLineSel = { fg = palette.bright_foreground, bg = palette.element_active },
        Title = { fg = palette.bright_blue, bold = true },
        Directory = { fg = palette.blue },
        MatchParen = { fg = palette.bright_blue, underline = true },
        NonText = { fg = palette.gray },
        SpecialKey = { fg = palette.gray },
        Folded = { fg = palette.light_gray, bg = nil },
        FoldColumn = { fg = palette.light_gray, bg = nil },
        EndOfBuffer = { fg = palette.gray },
        
        -- Syntax - Enhanced with more specific token types
        Comment = { fg = palette.light_gray, style = M.options.styles.comments },
        Constant = { fg = palette.yellow, bold = true },
        String = { fg = palette.green, style = M.options.styles.strings },
        Character = { fg = palette.green },
        Number = { fg = palette.yellow, style = M.options.styles.numbers },
        Boolean = { fg = palette.yellow, style = M.options.styles.booleans },
        Float = { fg = palette.yellow },
        Identifier = { fg = palette.identifier, style = M.options.styles.variables },
        Function = { fg = palette.blue, style = M.options.styles.functions },
        Statement = { fg = palette.purple, bold = true },
        Conditional = { fg = palette.purple, style = M.options.styles.conditionals },
        Repeat = { fg = palette.purple, style = M.options.styles.loops },
        Label = { fg = palette.purple },
        Operator = { fg = palette.bright_foreground, style = M.options.styles.operators },
        Keyword = { fg = palette.purple, style = M.options.styles.keywords },
        Exception = { fg = palette.purple },
        PreProc = { fg = palette.purple },
        Include = { fg = palette.purple },
        Define = { fg = palette.purple },
        Macro = { fg = palette.purple },
        PreCondit = { fg = palette.purple },
        Type = { fg = palette.yellow, style = M.options.styles.types },
        StorageClass = { fg = palette.yellow },
        Structure = { fg = palette.yellow },
        Typedef = { fg = palette.yellow },
        Special = { fg = palette.cyan },
        SpecialChar = { fg = palette.cyan, bold = true },
        Tag = { fg = palette.red },
        Delimiter = { fg = palette.bright_foreground },
        SpecialComment = { fg = palette.light_gray, italic = true },
        Debug = { fg = palette.red },
        Underlined = { underline = true },
        Error = { fg = palette.error },
        Todo = { fg = palette.purple, bold = true },
        
        -- Diff - Enhanced with better visibility
        DiffAdd = { bg = palette.diff_add },
        DiffChange = { bg = palette.diff_change },
        DiffDelete = { bg = palette.diff_delete },
        DiffText = { bg = palette.diff_text },
        
        -- Diagnostics - Set backgrounds to nil for transparency
        DiagnosticError = { fg = palette.error },
        DiagnosticWarn = { fg = palette.warning },
        DiagnosticInfo = { fg = palette.info },
        DiagnosticHint = { fg = palette.hint },
        DiagnosticUnderlineError = { undercurl = true, sp = palette.error },
        DiagnosticUnderlineWarn = { undercurl = true, sp = palette.warning },
        DiagnosticUnderlineInfo = { undercurl = true, sp = palette.info },
        DiagnosticUnderlineHint = { undercurl = true, sp = palette.hint },
        DiagnosticFloatingError = { fg = palette.error, bg = nil },
        DiagnosticFloatingWarn = { fg = palette.warning, bg = nil },
        DiagnosticFloatingInfo = { fg = palette.info, bg = nil },
        DiagnosticFloatingHint = { fg = palette.hint, bg = nil },
        DiagnosticSignError = { fg = palette.error },
        DiagnosticSignWarn = { fg = palette.warning },
        DiagnosticSignInfo = { fg = palette.info },
        DiagnosticSignHint = { fg = palette.hint },
        DiagnosticVirtualTextError = { fg = palette.error, bg = nil },
        DiagnosticVirtualTextWarn = { fg = palette.warning, bg = nil },
        DiagnosticVirtualTextInfo = { fg = palette.info, bg = nil },
        DiagnosticVirtualTextHint = { fg = palette.hint, bg = nil },
        
        -- LSP - Set backgrounds to nil for transparency
        LspReferenceText = { bg = nil },
        LspReferenceRead = { bg = nil },
        LspReferenceWrite = { bg = nil },
        LspSignatureActiveParameter = { fg = palette.bright_yellow, bold = true, italic = true },
        LspCodeLens = { fg = palette.light_gray, italic = true },
        LspInlayHint = { fg = palette.light_gray, bg = nil, italic = true },
        
        -- Indent-Blankline - Added support for indent guides
        IndentBlanklineChar = { fg = palette.indent_guide },
        IndentBlanklineContextChar = { fg = palette.indent_guide_active },
        IblIndent = { fg = palette.indent_guide },
        IblScope = { fg = palette.indent_guide_active },
        
        -- Illuminate - Set backgrounds to nil for transparency
        IlluminatedWordText = { bg = nil },
        IlluminatedWordRead = { bg = nil },
        IlluminatedWordWrite = { bg = nil },
        
        -- Specific TreeSitter customizations
        Parameter = { fg = palette.parameter, style = M.options.styles.parameters },
        Method = { fg = palette.method },
        MethodCall = { fg = palette.method },
        KeywordControl = { fg = palette.keyword_control, bold = true },
        
        -- Neovim Terminal Colors - Better consistency
        TermCursor = { bg = palette.bright_foreground },
        TermCursorNC = { bg = palette.light_gray },
    }
    
    -- Set background to none for transparent background
    if M.options.transparent_background then
        highlights.Normal.bg = nil
        highlights.NormalFloat.bg = nil
        highlights.FloatBorder.bg = nil
        highlights.SignColumn.bg = nil
        highlights.LineNr.bg = nil
        highlights.FoldColumn.bg = nil
        highlights.WinBar.bg = nil
        highlights.WinBarNC.bg = nil
        highlights.CursorLineNr.bg = nil
        highlights.Pmenu.bg = nil
        highlights.PmenuSbar.bg = nil
        highlights.StatusLine.bg = nil
        highlights.StatusLineNC.bg = nil
        highlights.TabLine.bg = nil
        highlights.TabLineFill.bg = nil
        highlights.Folded.bg = nil
        highlights.ColorColumn.bg = nil
        highlights.LspReferenceText.bg = nil
        highlights.LspReferenceRead.bg = nil
        highlights.LspReferenceWrite.bg = nil
        highlights.LspInlayHint.bg = nil
        highlights.IlluminatedWordText.bg = nil
        highlights.IlluminatedWordRead.bg = nil
        highlights.IlluminatedWordWrite.bg = nil
        highlights.DiagnosticFloatingError.bg = nil
        highlights.DiagnosticFloatingWarn.bg = nil
        highlights.DiagnosticFloatingInfo.bg = nil
        highlights.DiagnosticFloatingHint.bg = nil
        highlights.DiagnosticVirtualTextError.bg = nil
        highlights.DiagnosticVirtualTextWarn.bg = nil
        highlights.DiagnosticVirtualTextInfo.bg = nil
        highlights.DiagnosticVirtualTextHint.bg = nil
    end
    
    -- Load plugin integrations
    if M.options.integrations then
        local integration_highlights = require("flow.groups.integrations").get(palette, M.options)
        -- Ensure plugin backgrounds are transparent
        if M.options.transparent_background then
            for group, styles in pairs(integration_highlights) do
                styles.bg = nil
            end
        end
        highlights = vim.tbl_deep_extend("force", highlights, integration_highlights)
    end
    
    -- Apply dim_inactive feature
    if M.options.features.dim_inactive and M.options.features.dim_inactive.enabled then
        local dim_percentage = M.options.features.dim_inactive.percentage or 0.15
        highlights.NormalNC = { 
            fg = palette.muted_foreground,
            bg = M.options.transparent_background and nil or palette.background,
        }
    end
    
    -- Apply highlights with style processing
    for group, styles in pairs(highlights) do
        if styles.style then
            local style = styles.style
            styles.style = nil
            if type(style) == "table" then
                for _, v in ipairs(style) do
                    styles[v] = true
                end
            elseif type(style) == "string" then
                styles[style] = true
            end
        end
        vim.api.nvim_set_hl(0, group, styles)
    end
    
    -- Apply terminal colors
    if M.options.term_colors then
        vim.g.terminal_color_0 = palette.black
        vim.g.terminal_color_1 = palette.red
        vim.g.terminal_color_2 = palette.green
        vim.g.terminal_color_3 = palette.yellow
        vim.g.terminal_color_4 = palette.blue
        vim.g.terminal_color_5 = palette.purple
        vim.g.terminal_color_6 = palette.cyan
        vim.g.terminal_color_7 = palette.white
        vim.g.terminal_color_8 = palette.bright_black
        vim.g.terminal_color_9 = palette.bright_red
        vim.g.terminal_color_10 = palette.bright_green
        vim.g.terminal_color_11 = palette.bright_yellow
        vim.g.terminal_color_12 = palette.bright_blue
        vim.g.terminal_color_13 = palette.bright_purple
        vim.g.terminal_color_14 = palette.bright_cyan
        vim.g.terminal_color_15 = palette.bright_white
    end
end

function M.load()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.g.colors_name = "flow"
    vim.o.termguicolors = true
    apply_highlights()
end

return M
