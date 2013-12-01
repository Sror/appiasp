var isMobile = {
    Android: function(){
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function(){
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function(){
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function(){
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Firefox: function(){
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function(){
        return isMobile.Android()||isMobile.BlackBerry()||isMobile.iOS()||isMobile.Opera()||isMobile.Windows();
    }
};

var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicity call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        console.log('Received Event: ' + id);
    },
    openView: function(viewId){

        window.history.pushState({id: viewId}, 'Viewing: #'+viewId , '#'+viewId);    

        $('.view').hide();

        $('#'+viewId).show();

    }
};

// Only for desktop tests (remove before publish)
$(document).ready(function(){
    $(document).trigger('deviceready');
});



$(document).on('deviceready', function(e){

    $.anystretch("img/bg-splash.jpg", {speed: 1});

    // Calculate content height
    $('.content').height($(document).outerHeight(true)-72);
    $('#magazine .magazine-view').css('height', ($(document).outerHeight(true)-72)+'px');
    $('#magazine .magazine-view .iframe').css('height', ($(document).outerHeight(true)-72)+'px');


    // Add navigation links
    $('.item-menu').on('click tap', function(e) {
        e.preventDefault();

        var viewId = $(this).data('view');

        app.openView(viewId);
    });

    // Add magazine links
    // $('#magazine .magazine-list a').on('click tap', function(e) {
    //     e.preventDefault();

    //     var fileUrl = $(this).data('file');

    //     $('#magazine .magazine-list').hide();
    //     $('#magazine .back-btn').show();
    //     $('#magazine .magazine-view .iframe').attr('src','zoom/'+fileUrl);
    //     $('#magazine .magazine-view').show();
    // });
    // $('#magazine .back-btn').on('click tap', function(e) {
    //     e.preventDefault();

    //     $('#magazine .magazine-list').show();
    //     $(this).hide();
    //     $('#magazine .magazine-view').hide();
    // });

    // Add news links
    $('#news .back-btn').on('click tap', function(e) {
        e.preventDefault();

        $('#news .news-list').show();
        $(this).hide();
        $('#news .news-detail').hide();
    });

    // Add contact link
    $('#contact .send-btn').on('click tap', function(e) {
        e.preventDefault();

        var contactName = $('#contactName'),
            contactEmail = $('#contactEmail'),
            contactMessage = $('#contactMessage');

        $.ajax({
            type: "POST",
            url: 'http://synergic.com.br/clientes/iasp/wsapp/?function=Contact',
            data: { name:contactName.val(), email:contactEmail.val(), message:contactMessage.val() }
        });

        alert('Enviado com sucesso');

        contactName.val('');
        contactEmail.val('');
        contactMessage.val('');

    });

    // Open the first view
    app.openView('splash');

    // Loading news
    $.getJSON( "http://synergic.com.br/clientes/iasp/wsapp/?function=GetLastsNoticiasByCategory&categoryId=2", function(data) {
        var newsList = $('#news .content .news-list');

        $.each( data, function( key, news ) {
            newsList.append("<li><a href=\"#\" data-news=\""+news.id+"\"><p class=\"date\">"+news.date+"</p><p class=\"image\"><img src="+news.image+"></p><p class=\"title\">"+news.title+"</p><p class=\"text\">"+news.preview+"</p></a></li>");
        });

        $('#news .news-list a').on('click tap', function(e) {
            e.preventDefault();

            var newsId = $(this).data('news');

            $('#news .news-list').hide();
            $('#news .back-btn').show();
            $('#news .news-detail').show();

            loadNews(newsId);
        });

    });

});


function loadNews(newsId){
    var url = "http://synergic.com.br/clientes/iasp/wsapp/?function=GetNoticia&newsId="+newsId;
    $.getJSON( url, {processData:false}, function(data) {
        var newsDetail = $('.news-detail');
        newsDetail.html("<p class=\"date\">"+data.date+"</p><p class=\"title\">"+data.title+"</p>"+data.content);
    });
}


// Test only
$(window).resize(function(){
    $('.content').height($(document).outerHeight(true)-72);    
});


window.onpopstate = function(e){
    if(e.state){
        var id = e.state.id;
        app.openView(id);    
    }
}




























