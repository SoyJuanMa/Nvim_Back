-- Configuración personalizada de nvim-web-devicons
-- Sobrescribe los iconos por defecto con los que querés

return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = function(_, opts)
      -- Sobrescribir iconos por extensión
      opts.override = vim.tbl_extend("force", opts.override or {}, {
        -- JavaScript/TypeScript
        js = { icon = "󰌞", color = "#f9e2af", name = "Js" },
        mjs = { icon = "󰌞", color = "#f9e2af", name = "Mjs" },
        cjs = { icon = "󰌞", color = "#f9e2af", name = "Cjs" },
        jsx = { icon = "󰜈", color = "#f9e2af", name = "Jsx" },
        ts = { icon = "󰛦", color = "#89b4fa", name = "Ts" },
        tsx = { icon = "󰜈", color = "#74c7ec", name = "Tsx" },
        java = { icon = "", color = "#f38ba8", name = "Java" },

        -- Frameworks
        astro = { icon = "", color = "#fab387", name = "Astro" },
        vue = { icon = "", color = "#a6e3a1", name = "Vue" },
        svelte = { icon = "", color = "#fab387", name = "Svelte" },

        -- Otros lenguajes
        md = { icon = "󰍔", color = "#89b4fa", name = "Markdown" },
        go = { icon = "", color = "#89dceb", name = "Go" },
        py = { icon = "", color = "#f9e2af", name = "Python" },
        rs = { icon = "󱘗", color = "#fab387", name = "Rust" },
        lua = { icon = "", color = "#89b4fa", name = "Lua" },

        -- HTML/CSS
        html = { icon = "", color = "#fab387", name = "Html" },
        css = { icon = "", color = "#89b4fa", name = "Css" },
        scss = { icon = "", color = "#cba6f7", name = "Scss" },
        sass = { icon = "", color = "#cba6f7", name = "Sass" },

        -- Config/Data
        json = { icon = "󰘦", color = "#f9e2af", name = "Json" },
        yaml = { icon = "", color = "#9399b2", name = "Yaml" },
        yml = { icon = "", color = "#9399b2", name = "Yml" },
        toml = { icon = "", color = "#9399b2", name = "Toml" },

        -- Shell
        sh = { icon = "", color = "#9399b2", name = "Shell" },
        bash = { icon = "", color = "#9399b2", name = "Bash" },
        zsh = { icon = "", color = "#9399b2", name = "Zsh" },

        -- Tests (colores diferenciados)
        ["test.js"] = { icon = "󰙨", color = "#f9e2af", name = "TestJs" },
        ["test.jsx"] = { icon = "󰙨", color = "#f9e2af", name = "TestJsx" },
        ["test.ts"] = { icon = "󰙨", color = "#89dceb", name = "TestTs" },
        ["test.tsx"] = { icon = "󰙨", color = "#89dceb", name = "TestTsx" },
        ["spec.js"] = { icon = "󰙨", color = "#f9e2af", name = "SpecJs" },
        ["spec.jsx"] = { icon = "󰙨", color = "#f9e2af", name = "SpecJsx" },
        ["spec.ts"] = { icon = "󰙨", color = "#89dceb", name = "SpecTs" },
        ["spec.tsx"] = { icon = "󰙨", color = "#89dceb", name = "SpecTsx" },

        -- Database
        prisma = { icon = "", color = "#89b4fa", name = "Prisma" },
        sql = { icon = "", color = "#f9e2af", name = "Sql" },

        -- Otros formatos
        pdf = { icon = "", color = "#f38ba8", name = "Pdf" },
        zip = { icon = "", color = "#fab387", name = "Zip" },
        tar = { icon = "", color = "#fab387", name = "Tar" },
        gz = { icon = "󱝊", color = "#fab387", name = "Gz" },

        -- Images
        png = { icon = "󰸭", color = "#cba6f7", name = "Png" },
        jpg = { icon = "󰈥", color = "#cba6f7", name = "Jpg" },
        jpeg = { icon = "󰈥", color = "#cba6f7", name = "Jpeg" },
        gif = { icon = "󰵸", color = "#cba6f7", name = "Gif" },
        svg = { icon = "", color = "#fab387", name = "Svg" },
        webp = { icon = "", color = "#cba6f7", name = "Webp" },
        ico = { icon = "", color = "#f9e2af", name = "Ico" },

        -- Fonts
        ttf = { icon = "", color = "#9399b2", name = "TrueTypeFont" },
        woff = { icon = "", color = "#9399b2", name = "Woff" },
        woff2 = { icon = "", color = "#9399b2", name = "Woff2" },
      })

      -- Sobrescribir iconos por nombre de archivo exacto
      opts.override_by_filename = vim.tbl_extend("force", opts.override_by_filename or {}, {
        -- Package managers
        ["package.json"] = { icon = "", color = "#a6e3a1", name = "PackageJson" },
        ["package-lock.json"] = { icon = "", color = "#a6e3a1", name = "PackageLockJson" },
        ["yarn.lock"] = { icon = "", color = "#89dceb", name = "YarnLock" },
        ["pnpm-lock.yaml"] = { icon = "", color = "#fab387", name = "PnpmLock" },
        ["bun.lockb"] = { icon = "", color = "#f9e2af", name = "BunLock" },

        -- TypeScript
        ["tsconfig.json"] = { icon = "󰛦", color = "#89b4fa", name = "TsConfig" },
        ["tsconfig.node.json"] = { icon = "󰛦", color = "#89b4fa", name = "TsConfigNode" },
        ["tsconfig.app.json"] = { icon = "󰛦", color = "#89b4fa", name = "TsConfigApp" },

        -- Build tools
        ["vite.config.js"] = { icon = "󱐋", color = "#cba6f7", name = "ViteConfig" },
        ["vite.config.ts"] = { icon = "󱐋", color = "#cba6f7", name = "ViteConfigTs" },
        ["vitest.config.js"] = { icon = "󱐋", color = "#a6e3a1", name = "VitestConfig" },
        ["vitest.config.ts"] = { icon = "󱐋", color = "#a6e3a1", name = "VitestConfigTs" },
        ["webpack.config.js"] = { icon = "󰜫", color = "#89dceb", name = "WebpackConfig" },
        ["rollup.config.js"] = { icon = "", color = "#f38ba8", name = "RollupConfig" },

        -- Frameworks
        ["next.config.js"] = { icon = "󰈔", color = "#89b4fa", name = "NextConfig" },
        ["next.config.mjs"] = { icon = "󰈔", color = "#89b4fa", name = "NextConfigMjs" },
        ["next.config.ts"] = { icon = "󰈔", color = "#89b4fa", name = "NextConfigTs" },
        ["nuxt.config.js"] = { icon = "󱄆", color = "#a6e3a1", name = "NuxtConfig" },
        ["nuxt.config.ts"] = { icon = "󱄆", color = "#a6e3a1", name = "NuxtConfigTs" },
        ["astro.config.mjs"] = { icon = "", color = "#fab387", name = "AstroConfig" },

        -- Styling
        ["tailwind.config.js"] = { icon = "󱏿", color = "#74c7ec", name = "TailwindConfig" },
        ["tailwind.config.ts"] = { icon = "󱏿", color = "#74c7ec", name = "TailwindConfigTs" },
        ["postcss.config.js"] = { icon = "", color = "#f38ba8", name = "PostCSSConfig" },
        ["postcss.config.cjs"] = { icon = "", color = "#f38ba8", name = "PostCSSConfigCjs" },

        -- Testing
        ["jest.config.js"] = { icon = "󰙨", color = "#f38ba8", name = "JestConfig" },
        ["jest.config.ts"] = { icon = "󰙨", color = "#f38ba8", name = "JestConfigTs" },
        ["jest.setup.js"] = { icon = "󰙨", color = "#f38ba8", name = "JestSetup" },
        ["jest.setup.ts"] = { icon = "󰙨", color = "#f38ba8", name = "JestSetupTs" },
        ["playwright.config.js"] = { icon = "󰐕", color = "#a6e3a1", name = "PlaywrightConfig" },
        ["playwright.config.ts"] = { icon = "󰐕", color = "#a6e3a1", name = "PlaywrightConfigTs" },
        ["cypress.config.js"] = { icon = "", color = "#89dceb", name = "CypressConfig" },
        ["cypress.config.ts"] = { icon = "", color = "#89dceb", name = "CypressConfigTs" },

        -- Linting/Formatting
        [".eslintrc"] = { icon = "󰱺", color = "#cba6f7", name = "Eslintrc" },
        [".eslintrc.js"] = { icon = "󰱺", color = "#cba6f7", name = "EslintrcJs" },
        [".eslintrc.json"] = { icon = "󰱺", color = "#cba6f7", name = "EslintrcJson" },
        ["eslint.config.js"] = { icon = "󰱺", color = "#cba6f7", name = "EslintConfig" },
        ["eslint.config.mjs"] = { icon = "󰱺", color = "#cba6f7", name = "EslintConfigMjs" },
        [".eslintignore"] = { icon = "󰱺", color = "#9399b2", name = "EslintIgnore" },
        [".prettierrc"] = { icon = "", color = "#fab387", name = "Prettierrc" },
        [".prettierrc.js"] = { icon = "", color = "#fab387", name = "PrettierrcJs" },
        [".prettierrc.json"] = { icon = "", color = "#fab387", name = "PrettierrcJson" },
        ["prettier.config.js"] = { icon = "", color = "#fab387", name = "PrettierConfig" },
        [".prettierignore"] = { icon = "", color = "#9399b2", name = "PrettierIgnore" },
        [".editorconfig"] = { icon = "", color = "#9399b2", name = "EditorConfig" },

        -- Database
        ["schema.prisma"] = { icon = "", color = "#89b4fa", name = "PrismaSchema" },
        [".prisma"] = { icon = "", color = "#89b4fa", name = "Prisma" },

        -- Docker
        ["Dockerfile"] = { icon = "󰡨", color = "#89dceb", name = "Dockerfile" },
        ["docker-compose.yml"] = { icon = "󰡨", color = "#89dceb", name = "DockerCompose" },
        ["docker-compose.yaml"] = { icon = "󰡨", color = "#89dceb", name = "DockerCompose" },
        [".dockerignore"] = { icon = "󰡨", color = "#9399b2", name = "DockerIgnore" },

        -- Git
        [".gitignore"] = { icon = "", color = "#f38ba8", name = "GitIgnore" },
        [".gitattributes"] = { icon = "", color = "#f38ba8", name = "GitAttributes" },
        [".gitmodules"] = { icon = "", color = "#f38ba8", name = "GitModules" },
        [".DS_Store"] = { icon = "", color = "#9399b2", name = "DSStore" },

        -- Env
        [".env"] = { icon = "󱁻", color = "#f9e2af", name = "Env" },
        [".env.template"] = { icon = "󱁻", color = "#f9e2af", name = "EnvTemplate" },

        [".env.local"] = { icon = "󱁻", color = "#f9e2af", name = "EnvLocal" },
        [".env.example"] = { icon = "󱁻", color = "#f9e2af", name = "EnvExample" },
        [".env.development"] = { icon = "󱁻", color = "#f9e2af", name = "EnvDevelopment" },
        [".env.production"] = { icon = "󱁻", color = "#f9e2af", name = "EnvProduction" },
        [".env.test"] = { icon = "󱁻", color = "#f9e2af", name = "EnvTest" },

        -- README
        ["README.md"] = { icon = "", color = "#f9e2af", name = "Readme" },
        ["README"] = { icon = "", color = "#f9e2af", name = "Readme" },
        ["readme.md"] = { icon = "", color = "#f9e2af", name = "Readme" },

        -- License
        ["LICENSE"] = { icon = "󰿃", color = "#f9e2af", name = "License" },
        ["LICENSE.md"] = { icon = "󰿃", color = "#f9e2af", name = "LicenseMd" },
        ["LICENSE.txt"] = { icon = "󰿃", color = "#f9e2af", name = "LicenseTxt" },

        -- Otros configs
        [".nvmrc"] = { icon = "", color = "#a6e3a1", name = "Nvmrc" },
        [".node-version"] = { icon = "", color = "#a6e3a1", name = "NodeVersion" },
        [".npmrc"] = { icon = "󰛷", color = "#f38ba8", name = "Npmrc" },
        ["nodemon.json"] = { icon = "", color = "#a6e3a1", name = "Nodemon" },
        ["renovate.json"] = { icon = "", color = "#89dceb", name = "Renovate" },
      })

      -- Sobrescribir iconos por nombre de carpeta
      opts.override_by_folder_name = vim.tbl_extend("force", opts.override_by_folder_name or {}, {
        -- Dependencies
        node_modules = { icon = "", color = "#a6e3a1", name = "NodeModules" },
        [".git"] = { icon = "", color = "#f38ba8", name = "Git" },
        [".github"] = { icon = "", color = "#9399b2", name = "GitHub" },
        [".vscode"] = { icon = "", color = "#89dceb", name = "VSCode" },

        -- Source directories
        src = { icon = "", color = "#89dceb", name = "Src" },
        lib = { icon = "", color = "#cba6f7", name = "Lib" },
        dist = { icon = "", color = "#fab387", name = "Dist" },
        build = { icon = "", color = "#fab387", name = "Build" },
        out = { icon = "", color = "#fab387", name = "Out" },
        public = { icon = "", color = "#f9e2af", name = "Public" },
        static = { icon = "", color = "#f9e2af", name = "Static" },
        assets = { icon = "", color = "#cba6f7", name = "Assets" },

        -- Testing
        test = { icon = "󰙨", color = "#a6e3a1", name = "Test" },
        tests = { icon = "󰙨", color = "#a6e3a1", name = "Tests" },
        __tests__ = { icon = "󰙨", color = "#a6e3a1", name = "TestsDouble" },
        ["e2e"] = { icon = "󰙨", color = "#89dceb", name = "E2E" },
        cypress = { icon = "", color = "#89dceb", name = "Cypress" },
        ["playwright"] = { icon = "󰐕", color = "#a6e3a1", name = "Playwright" },

        -- Frontend architecture
        components = { icon = "", color = "#74c7ec", name = "Components" },
        pages = { icon = "", color = "#fab387", name = "Pages" },
        views = { icon = "󰉖", color = "#fab387", name = "Views" },
        layouts = { icon = "", color = "#cba6f7", name = "Layouts" },
        hooks = { icon = "", color = "#f9e2af", name = "Hooks" },
        context = { icon = "", color = "#f9e2af", name = "Context" },
        store = { icon = "", color = "#f38ba8", name = "Store" },
        styles = { icon = "", color = "#cba6f7", name = "Styles" },
        css = { icon = "", color = "#89b4fa", name = "Css" },

        -- Backend architecture (DDD/Clean Architecture)
        domain = { icon = "󰜬", color = "#f9e2af", name = "Domain" },
        application = { icon = "󰘧", color = "#89dceb", name = "Application" },
        infrastructure = { icon = "", color = "#9399b2", name = "Infrastructure" },
        services = { icon = "", color = "#a6e3a1", name = "Services" },
        controllers = { icon = "", color = "#fab387", name = "Controllers" },
        routes = { icon = "", color = "#cba6f7", name = "Routes" },
        api = { icon = "", color = "#74c7ec", name = "Api" },
        models = { icon = "", color = "#f9e2af", name = "Models" },
        entities = { icon = "", color = "#f9e2af", name = "Entities" },
        repositories = { icon = "", color = "#89b4fa", name = "Repositories" },
        middleware = { icon = "", color = "#9399b2", name = "Middleware" },
        utils = { icon = "", color = "#9399b2", name = "Utils" },
        helpers = { icon = "", color = "#9399b2", name = "Helpers" },
        config = { icon = "", color = "#9399b2", name = "Config" },

        -- Media
        images = { icon = "", color = "#cba6f7", name = "Images" },
        img = { icon = "", color = "#cba6f7", name = "Img" },
        icons = { icon = "", color = "#fab387", name = "Icons" },
        fonts = { icon = "", color = "#9399b2", name = "Fonts" },
        media = { icon = "", color = "#cba6f7", name = "Media" },

        -- Documentation
        docs = { icon = "", color = "#89b4fa", name = "Docs" },
        doc = { icon = "", color = "#89b4fa", name = "Doc" },
        documentation = { icon = "", color = "#89b4fa", name = "Documentation" },

        -- Scripts
        scripts = { icon = "", color = "#a6e3a1", name = "Scripts" },
        bin = { icon = "", color = "#9399b2", name = "Bin" },

        -- Types
        types = { icon = "󰛦", color = "#89b4fa", name = "Types" },
        ["@types"] = { icon = "󰛦", color = "#89b4fa", name = "TypesAt" },

        -- Database
        migrations = { icon = "", color = "#f9e2af", name = "Migrations" },
        seeds = { icon = "󰔨", color = "#a6e3a1", name = "Seeds" },
        prisma = { icon = "", color = "#89b4fa", name = "PrismaFolder" },

        -- Logs/Temp
        logs = { icon = "", color = "#9399b2", name = "Logs" },
        tmp = { icon = "", color = "#9399b2", name = "Tmp" },
        temp = { icon = "", color = "#9399b2", name = "Temp" },
        cache = { icon = "", color = "#9399b2", name = "Cache" },

        -- Containers
        docker = { icon = "󰡨", color = "#89dceb", name = "DockerFolder" },
        [".docker"] = { icon = "󰡨", color = "#89dceb", name = "DockerHidden" },
      })

      return opts
    end,
  },
}
