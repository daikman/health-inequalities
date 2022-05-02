// remove previous plot
svg.selectAll("*").remove()

// get list of all metrics
const allMetrics = data[1]

// get dataframe from passed in data
data = data[0]

// sort it by SIMD
data.sort((a, b) => d3.ascending(a.SIMD, b.SIMD))

// find metrics to group data by
const metrics = Object.keys(data[0])
metrics.splice(0, 1)

// find which metrics have been selected (to know which color to use)
const metricsIndex = metrics.map(
  d => allMetrics.indexOf(d)
)

// nest the data by metric
// i.e., an array of datasets for each available metric
const dataGroups = metrics.map(metric => data.map(d => {
  return { SIMD: d.SIMD, metric: d[metric] }
}))

// PLOTTTING
// define margins
const margin = {top: 10, right: 30, bottom: 40, left: 30}

// define x scale
const xVals = data.map(d => d.SIMD)
const x = d3.scaleLinear()
  .domain([d3.min(xVals), d3.max(xVals)])
  .range([margin.left, width - margin.right])

// define y scale
let metricMaxes = []
for (dataset of dataGroups) {
  metricMaxes.push(
    d3.max(dataset.map(d => d.metric))
  )
}
const y = d3.scaleLinear()
  .domain([0, d3.max(metricMaxes)])
  .range([height - margin.bottom, margin.top]);

// draw lines
let lines = svg.selectAll(".line")
  .data(dataGroups)
  .enter()
  .append("path")
    .attr("fill", "none")
    .attr("stroke", (d, i) => lineColours[metricsIndex[i]])
    .attr("stroke-width", 3)
    .attr("opacity", 0.8)
    .attr("d", (d, i) => {
      return d3.line()
      .x(function(d) { return x(d.SIMD) })
      .y(function(d) { return y(d.metric) })
      (d)
    })

// add mouse interaction
lines.on("mouseover", function(d, i) {
  mouseOver(this)
})

lines.on("mouseout", function(d, i) {
  mouseOut(this)
})

// draw axes
svg.append("g")
   .attr("transform", "translate(" + margin.left + ",0)")
   .attr("opacity", 0.7)
   .call(d3.axisLeft(y).ticks(d3.max(xVals)))
   .selectAll("text")
     .style("font-weight", "bold");

svg.append("g")
  .attr("transform", "translate(0," + (height - margin.bottom) + ")")
  .attr("opacity", 0.7)
  .call(d3.axisBottom(x))
  .selectAll("text")
    .style("font-weight", "bold");

// draw x-axis label
svg.append("text")
   .attr("x", margin.left + (width - margin.right - margin.left)/2)
   .attr("y", (height + margin.top) - margin.bottom + 24)
   .attr("text-anchor", "middle")
   .attr("font-weight", "bold")
   .text("Deprivation")

// define mouse functions
function mouseOver(self) {
  d3.select(self)
    .transition()
    .duration(50)
    .attr("opacity", 1)
    .attr("stroke-width", 5)
}

function mouseOut(self) {
  d3.select(self)
    .transition()
    .duration(200)
    .attr("opacity", 0.8)
    .attr("stroke-width", 3)
}
