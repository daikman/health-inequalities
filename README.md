# Health Inequalities in Scotland

This app shows show examples of how more 'deprived' areas have poorer health outcomes.
The data is all from the [Public Health Scotland's Open Data portal](https://www.opendata.nhs.scot/), which I manage at the time of writing. I built the app using R Shiny. It requires the installation of [{phsopendata}](https://github.com/Public-Health-Scotland/phsopendata) for retrieving the data on app start.

## Responsive 'routing'

Instead of using CSS media queries to make the app responsive to screen sizes, I created entirely separate front-ends for windows wider or narrower than 766px. Both screens are always rendered, but one is always hidden. 

This required me to define a custom Shiny 'input' for window width, that updates whenever the window size changes. I did this using jQuery in the file "./R/customShinyInputs.R".

## Scroll events

I needed to define another variable in order to trigger events based on scroll height. For example, the content of the sidebar in the 'big app' changes depending on the chart being displayed in the column to its right.

## Approach to CSS

`custom.css` applies a font to the body, all other CSS is within the many R files, where the UI is defined. I thought this approach made sense as I was thinking about each UI element as independent pieces. If I want to customize the style of something, I can just go to the file that produces it and edit the style there. 

The downside to this approach is that it is more difficult to edit the general style of the app.


