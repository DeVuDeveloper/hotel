class CookieBar {
    constructor() {
        this.cookiesBar = document.getElementById('cookies-bar');
    }

    init() {
        if (!this.cookiesAllowed()) {
            // Show the cookie bar if cookies are not allowed
            this.cookiesBar.classList.remove('hidden');
        }

        this.addButtonBehaviors();
    }

    cookiesAllowed() {
        return Cookies.get('allow_cookies') === 'yes';
    }

    addButtonBehaviors() {
        if (!this.cookiesBar) {
            return;
        }

        this.cookiesBar.querySelector('.accept').addEventListener('click', () => this.allowCookies(true));
        this.cookiesBar.querySelector('.reject').addEventListener('click', () => this.allowCookies(false));
    }

    appendGACode() {
        const gaScript = document.createElement('script');
        gaScript.async = true;
        gaScript.src = 'https://www.googletagmanager.com/gtag/js?id=G-081RNEE4JJ';
        document.head.appendChild(gaScript);
    
        gaScript.onload = () => {
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                window.dataLayer.push(arguments);
            }
            gtag('js', new Date());
            gtag('config', 'G-081RNEE4JJ');
        };
    }

    allowCookies(allow) {
        if (allow) {
            Cookies.set('allow_cookies', 'yes', { expires: 365 });
            this.appendGACode();
        } else {
            Cookies.set('allow_cookies', 'no', { expires: 365 });
        }

        this.cookiesBar.classList.add('hidden');
    }

    setSubscriptionCookie(subscribed) {
        Cookies.set('subscribed', subscribed ? 'yes' : 'no', { expires: 365 });
    }
}

document.addEventListener('turbo:load', function () {
    const cookieBar = new CookieBar();
    cookieBar.init();
});

document.addEventListener('DOMContentLoaded', function () {
    const cookieBar = new CookieBar();
    cookieBar.init();
});
