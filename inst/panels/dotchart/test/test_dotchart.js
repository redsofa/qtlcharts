// Generated by CoffeeScript 1.7.1
var h, halfh, halfw, margin, totalh, totalw, w;

h = 300;

w = 400;

margin = {
  left: 60,
  top: 40,
  right: 40,
  bottom: 40,
  inner: 5
};

halfh = h + margin.top + margin.bottom;

totalh = halfh * 2;

halfw = w + margin.left + margin.right;

totalw = halfw * 2;

d3.json("data.json", function(data) {
  var mychart;
  mychart = dotchart().xvar(0).yvar(1).xlab("X").ylab("Y").title("Jittered (default)").height(h).width(w).margin(margin);
  d3.select("div#chart1").datum(data).call(mychart);
  return mychart.pointsSelect().on("mouseover", function(d) {
    return d3.select(this).attr("r", mychart.pointsize() * 3).on("click", function(d) {
      return d3.select(this).attr("fill", "Orchid").on("mouseout", function(d) {
        return d3.select(this).attr("fill", mychart.pointcolor()).attr("r", mychart.pointsize());
      });
    });
  }).on("mouseout", function(d) {
    return d3.select(this).attr("fill", mychart.pointcolor()).attr("r", mychart.pointsize());
  });
});

d3.json("data.json", function(data) {
  var mychart;
  mychart = dotchart().xvar(0).yvar(1).xlab("X").ylab("Y").title("No jittering").height(h).width(w).margin(margin).xjitter(0);
  d3.select("div#chart2").datum(data).call(mychart);
  return mychart.pointsSelect().on("mouseover", function(d) {
    return d3.select(this).attr("r", mychart.pointsize() * 3).on("click", function(d) {
      return d3.select(this).attr("fill", "Orchid").on("mouseout", function(d) {
        return d3.select(this).attr("fill", mychart.pointcolor()).attr("r", mychart.pointsize());
      });
    });
  }).on("mouseout", function(d) {
    return d3.select(this).attr("fill", mychart.pointcolor()).attr("r", mychart.pointsize());
  });
});

d3.json("data.json", function(data) {
  var data2, mychart, x;
  mychart = dotchart().height(h).width(w).margin(margin).dataByInd(false);
  data2 = [
    (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        x = data[_i];
        _results.push(x[0]);
      }
      return _results;
    })(), (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        x = data[_i];
        _results.push(x[1]);
      }
      return _results;
    })()
  ];
  d3.select("div#chart3").datum(data2).call(mychart);
  return mychart.pointsSelect().on("mouseover", function(d) {
    return d3.select(this).attr("r", mychart.pointsize() * 3).on("click", function(d) {
      return d3.select(this).attr("fill", "Orchid").on("mouseout", function(d) {
        return d3.select(this).attr("fill", mychart.pointcolor()).attr("r", mychart.pointsize());
      });
    });
  }).on("mouseout", function(d) {
    return d3.select(this).attr("fill", mychart.pointcolor()).attr("r", mychart.pointsize());
  });
});
