data.sort((a, b) => d3.ascending(a.SIMD, b.SIMD))
const metrics = Object.keys(data[0])
metrics.splice(0, 1)

// define margins
const margin = {top: 10, right: 10, bottom: 20, left: 10}

// define x scale
const xVals = data.map(d => d.SIMD)
const x = d3.scaleLinear()
  .domain([d3.min(xVals), d3.max(xVals)])
  .range([margin.left, width - margin.right])

// define y scale
const y = d3.scaleLinear()
  .domain([0, 1])
  .range([height - margin.bottom, margin.top]);

// nest the data by metric
// i.e., an array of datasets for each available metric
const dataGroups = metrics.map(metric => data.map(d => {
  return { SIMD: d.SIMD, metric: d[metric]}
}))

// draw lines
let lines = svg.selectAll(".line")
  .data(dataGroups)
  .enter()
  .append("path")
    .attr("fill", "none")
    .attr("stroke", "#69b3a2")
    .attr("stroke-width", 2)
    .attr("opacity", 0.8)
    .attr("d", (d, i) => {
      return d3.line()
      .x(function(d) { return x(d.SIMD) })
      .y(function(d) { return y(d.metric) })
      (d)
    })

// draw points
//let points = svg.selectAll(".point")
//  .data(data)
//  .enter()
//  .append("circle")
//    .attr("cx", function(d) { return x(d.SIMD); })
//    .attr("cy", function(d) { return y(d.CrudeRate); })
//    .attr("r", 4)
//    .attr("fill", "#69b3a2")
//    .attr("opacity", 0.8)

lines.on("mouseover", function(d, i) {
  mouseOver(this)
})

lines.on("mouseout", function(d, i) {
  mouseOut(this)
})

// draw axes
//svg.append("g")
//   .attr("transform", "translate(" + margin.left + ",0)")
//   .call(d3.axisLeft(y));

svg.append("g")
  .attr("transform", "translate(0," + (height - margin.bottom) + ")")
  .call(d3.axisBottom(x))
  .selectAll("text")
    .attr("transform", "translate(-10,0)rotate(-45)")
    .style("text-anchor", "end");

function mouseOver(self) {
  d3.select(self)
    .transition()
    .duration(50)
    .attr("opacity", 1)
    .attr("stroke-width", 4)
}

function mouseOut(self) {
  d3.select(self)
    .transition()
    .duration(200)
    .attr("opacity", 0.8)
    .attr("stroke-width", 2)
}
