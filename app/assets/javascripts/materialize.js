$(document).ready(function(){
    // Initialize smooth scroll
    $('.scrollspy').scrollSpy();

    // Initialize collapse button
    $('.button-collapse').sideNav({
        menuWidth: 240, // Default is 240
        closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
      }
    );
    $('.collapsible').collapsible();    
});
