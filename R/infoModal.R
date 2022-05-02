infoModal <- function(id) {
  ns <- NS(id)

  div(
    # BUTTON
    div(
      icon("info"),
      id = ns("button"),
      style = "
        position: fixed;
        top: 16px; right: 16px;
        z-index: 20;
        text-align: center;
        background-color: black;
        padding: 4px 6px 4px 6px;
        cursor: pointer;
        color: white;
      "
    ),
    # add interaction
    tags$script(paste0("
      // toggle modal display
      $('#", ns("button"), "').click(function() {

        const modal = $('#", ns("modal"), "')
        const modalDOM = modal[0]
        const open = modalDOM.style.display == 'block'

        const icon = $('#", ns("button"), " i')

        if (open) {
          modal.css({display: 'none'})
          icon.toggleClass('fa-info')
          icon.toggleClass('fa-times')
        } else {
          modal.css({display: 'block'})
          icon.toggleClass('fa-info')
          icon.toggleClass('fa-times')
        }

      })

      // hover behaviour
      $('#", ns("button"), "').hover(
        function() {
          $('#", ns("button"), "').css({
            'background-color': 'transparent',
            color: 'black'
          })
        },
        function() {
          $('#", ns("button"), "').css({
            'background-color': 'black',
            color: 'white'
          })
        }
      )
    ")),

    # MODAL
    div(
      div(
        h1("Deprivation and Health"),
        HTML("
          <p>
            This app collates 'deprivation' related data from the
            <a href='https://www.opendata.nhs.scot/' target='_blank'>
              Scottish Health and Social Care Open Data
            </a> portal.
          </p>
          <p>
            Deprivation is defined by the <strong>Scottish Index of Multiple Deprivation</strong>.
            This is measure that ranks around 6,000 small areas of Scotland (called data zones) on factors
            such average household income, crime rate and overcrowded-ness.
          </p>
          <p>
            <strong>To interpret the charts</strong> the main thing you need to know is that the further
            right along the x-axis (the higher the number), the higher the deprivation index. So in
            general, the <strong>higher the number on the x-axis, the lower the average income
            / employment rate etc</strong>. Usually, the index is interpretted in the opposite way
            (a lower number means more deprivation), but I have flipped the numbers because I
            think it is more intuitive.
          </p>
          <p>
            <strong>To learn more about how this measure of deprivation works, go <a
            href='https://www.gov.scot/collections/scottish-index-of-multiple-deprivation-2020/'
            target='_blank'>here</a>.</strong>
          </p>
        "),
        # animation
        tags$style(HTML("
          .slide {
            animation-duration: 0.3s;
            animation-name: animate-slide;
            animation-fill-mode: forwards;
          }

          @keyframes animate-slide {
            0% { max-width: 0; opacity: 0; }
            100% { max-width: 800px; opacity: 1; }
          }
        ")),
        class = "slide",
        style = "
          position: fixed;
          top: 0;
          right: 0;
          padding: 10%;
          width: 100%;
          max-width: 800px;
          height: 100%;
          z-index: 15;
          background-color: white;
          overflow: auto;
        "),
      id = ns("modal"),
      style = "
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        margin: auto;
        background-color: black;
        background-color: rgba(0,0,0,0.8);
        display: none;
        z-index: 14;
        padding: 10%;
      "
    )
  )

}
