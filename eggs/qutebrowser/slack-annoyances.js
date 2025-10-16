// ==UserScript==
// @name         Auto-Click Slack Notifications Button and Close Banner
// @namespace    greasy
// @version      1
// @description  Automatically clicks the "Enable notifications" button on Slack if it exists and closes the banner that appears
// @author       Your Name
// @match        https://app.slack.com/client/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Function to click the "Enable notifications" button
    function clickNotificationButton() {
        const buttons = document.querySelectorAll('button.c-link--button');
        buttons.forEach(button => {
            if (button.textContent.includes("Enable notifications")) {
                button.click();
                console.log('Clicked the "Enable notifications" button.');
                setTimeout(closeBanner, 1000); // Delay to ensure the banner is displayed
            }
        });
    }

    // Function to close the banner if it exists
    function closeBanner() {
        const closeButton = document.querySelector('button[data-qa="banner_close_btn"]');
        if (closeButton) {
            closeButton.click();
            console.log('Closed the banner.');
        }
    }

    // Run the function when the DOM is fully loaded
    window.addEventListener('load', () => {
        setTimeout(clickNotificationButton, 4000); // Delay to ensure elements are loaded
    });
})();
