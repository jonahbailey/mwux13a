$ ->
  return unless $(".program, .schedule").length > 0

  $(".sections a").click ->
    $('.sections').css(position: 'fixed', top: '0px')
    $('html,body').scrollTo(this.hash, this.hash, gap:{y:-75})
    false

  sectionsTop = $('.sections').offset().top
  $(window).scroll ->
    currentSection = $('.sections a:first')
    $('.sections a').each ->
      if $($(this).attr("href")).offset().top <= $(window).scrollTop() + 150
        currentSection = $(this)
    $('.sections a.selected').removeClass("selected")
    currentSection.addClass("selected")

    if $(window).scrollTop() > sectionsTop
      $('.sections').css(position: 'fixed', top: '0px')
    else
      $('.sections').css(position: 'static')
