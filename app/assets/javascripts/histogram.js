jQuery(function() {
  var createHistogram = function(div, data) {
    var formatCount = d3.format("d");

    var svg = d3.select(div),
        margin = {top: 20, right: 20, bottom: 20, left: 20},
        width = jQuery(div).width() - margin.left - margin.right;
        height = jQuery(div).height() - margin.top - margin.bottom;
        g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var x = d3.scaleLinear()
      .domain(d3.extent(data))
      .range([0, width]);

    var bins = d3.histogram()
        .domain(x.domain())
        .thresholds(x.ticks(7))
        (data);

    var y = d3.scaleLinear()
        .domain([0, d3.max(bins, function(d) { return d.length; })])
        .range([height, 0]);

    var bar = g.selectAll(".bar")
      .data(bins)
      .enter().append("g")
        .attr("class", "bar")
        .attr("transform", function(d) { return "translate(" + x(d.x0) + "," + y(d.length) + ")"; });

    bar.append("rect")
        .attr("x", 1)
        .attr("width", x(bins[0].x1) - x(bins[0].x0) - 1)
        .attr("height", function(d) { return height - y(d.length); });

    bar.append("text")
        .attr("dy", ".75em")
        .attr("y", 6)
        .attr("x", (x(bins[0].x1) - x(bins[0].x0)) / 2)
        .attr("text-anchor", "middle")
        .text(function(d) { return (d.length > 0 ? formatCount(d.length) : null); });

    g.append("g")
        .attr("class", "axis axis--x")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x));
  };

  createHistogram("svg.offer_minimum", window.offers_minimum);
  createHistogram("svg.offer_medium", window.offers_medium);
  createHistogram("svg.offer_maximum", window.offers_maximum);
});
