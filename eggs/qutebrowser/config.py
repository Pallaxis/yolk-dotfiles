config.load_autoconfig(True)
c.content.autoplay = False
c.content.cookies.accept = 'all'
# c.content.blocking.adblock.lists = [
#     "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
#     "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
#     "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
#     "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
#     "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
#     "https://easylist.to/easylist/easylist.txt",
#     "https://easylist.to/easylist/easyprivacy.txt",
#     "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
#     "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt",
#     "https://easylist-downloads.adblockplus.org/global-filters%2Beasylist.txt",
# ]
c.content.blocking.adblock.lists = [ \
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
        "https://easylist.to/easylist/fanboy-annoyance.txt",
        "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
        "https://easylist.to/easylist/fanboy-social.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-general.txt",
        # "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
        ]
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:136.0) Gecko/20100101 Firefox/139.0', 'https://accounts.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/henry/.local/share/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///home/henry/.local/share/qutebrowser/userscripts/*')
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}', 'g': 'https://www.google.com/search?q={}', 'wiki': 'https://en.wikipedia.org/wiki/{}'}
c.url.start_pages = 'https://www.duck.ai'
c.zoom.default = '100%'
c.colors.webpage.preferred_color_scheme = 'dark'
c.fonts.default_family = ['JetBrainsMono Nerd Font', 'Noto Color Emoji']
c.fonts.default_size = '12pt'
config.bind('<Ctrl+a>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl+e>', 'fake-key <End>', mode='insert')
config.bind('<Ctrl+b>', 'fake-key <Left>', mode='insert')
config.bind('<Ctrl+f>', 'fake-key <Right>', mode='insert')
config.bind('<Alt+b>', 'fake-key <Ctrl+Left>', mode='insert')
config.bind('<Alt+f>', 'fake-key <Ctrl+Right>', mode='insert')
config.bind('<Alt+d>', 'fake-key <Ctrl+Delete>', mode='insert')
config.bind('<Ctrl+w>', 'fake-key <Ctrl+backspace>', mode='insert')
config.bind('<Alt+Delete>', 'fake-key <Ctrl+backspace>', mode='insert')
