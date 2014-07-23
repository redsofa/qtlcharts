// Generated by CoffeeScript 1.7.1
var crosstab;

crosstab = function() {
  var axispos, bordercolor, cellHeight, cellPad, cellWidth, chart, hilitcolor, margin, rectcolor, title, titlepos, xlab, ylab;
  cellHeight = 30;
  cellWidth = 80;
  cellPad = 20;
  margin = {
    left: 60,
    top: 40,
    right: 40,
    bottom: 40
  };
  axispos = {
    xtitle: 25,
    ytitle: 30,
    xlabel: 5,
    ylabel: 5
  };
  titlepos = 20;
  title = "";
  xlab = "";
  ylab = "";
  rectcolor = "#e6e6e6";
  hilitcolor = "#e9cfec";
  bordercolor = "black";
  chart = function(selection) {
    return selection.each(function(data) {
      var cells, collab, colrect, g, gEnter, height, i, j, n, ncol, nrow, rect, svg, tab, values, width, xscale, yscale, _i, _j, _k, _l, _ref, _ref1, _results, _results1;
      n = data.x.length;
      if (data.y.length !== n) {
        console.log("data.x.length != data.y.length");
      }
      ncol = data.xcat.length;
      if (d3.max(data.x) >= ncol || d3.min(data.x) < 0) {
        console.log("data.x should be in range 0-" + (ncol - 1));
      }
      nrow = data.ycat.length;
      if (d3.max(data.y) >= nrow || d3.min(data.y) < 0) {
        console.log("data.y should be in range 0-" + (nrow - 1));
      }
      tab = calc_crosstab(data);
      cells = [];
      for (i = _i = 0; 0 <= nrow ? _i <= nrow : _i >= nrow; i = 0 <= nrow ? ++_i : --_i) {
        for (j = _j = 0; 0 <= ncol ? _j <= ncol : _j >= ncol; j = 0 <= ncol ? ++_j : --_j) {
          cells.push({
            value: tab[i][j],
            row: i,
            col: j
          });
        }
      }
      width = margin.left + margin.right + (ncol + 2) * cellWidth;
      height = margin.top + margin.bottom + (nrow + 2) * cellHeight;
      xscale = d3.scale.ordinal().domain((function() {
        _results = [];
        for (var _k = 0, _ref = ncol + 1; 0 <= _ref ? _k <= _ref : _k >= _ref; 0 <= _ref ? _k++ : _k--){ _results.push(_k); }
        return _results;
      }).apply(this)).rangeBands([margin.left, width - margin.right], 0, 0);
      yscale = d3.scale.ordinal().domain((function() {
        _results1 = [];
        for (var _l = 0, _ref1 = nrow + 1; 0 <= _ref1 ? _l <= _ref1 : _l >= _ref1; 0 <= _ref1 ? _l++ : _l--){ _results1.push(_l); }
        return _results1;
      }).apply(this)).rangeBands([margin.top, height - margin.bottom], 0, 0);
      svg = d3.select(this).selectAll("svg").data([data]);
      gEnter = svg.enter().append("svg").append("g");
      svg.attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom);
      g = svg.select("g");
      rect = g.append("g").attr("id", "value_rect");
      rect.selectAll("empty").data(cells).enter().append("rect").attr("id", function(d) {
        return "cell_" + d.row + "_" + d.col;
      }).attr("x", function(d) {
        return xscale(d.col + 1);
      }).attr("y", function(d) {
        return yscale(d.row + 1);
      }).attr("width", cellWidth).attr("height", cellHeight).attr("fill", function(d) {
        if (d.col < ncol - 1 && d.row < nrow - 1) {
          return rectcolor;
        } else {
          return "none";
        }
      }).attr("stroke", function(d) {
        if (d.col < ncol - 1 && d.row < nrow - 1) {
          return rectcolor;
        } else {
          return "none";
        }
      }).attr("stroke-width", 0);
      rect.append("rect").attr("x", xscale(1)).attr("y", yscale(1)).attr("width", cellWidth * ncol).attr("height", cellHeight * nrow).attr("fill", "none").attr("stroke", bordercolor);
      rect.append("rect").attr("x", xscale(ncol + 1)).attr("y", yscale(nrow + 1)).attr("width", cellWidth).attr("height", cellHeight).attr("fill", "none").attr("stroke", bordercolor);
      values = g.append("g").attr("id", "values");
      values.selectAll("empty").data(cells).enter().append("text").attr("x", function(d) {
        return xscale(d.col + 1) + cellWidth - cellPad;
      }).attr("y", function(d) {
        return yscale(d.row + 1) + cellHeight / 2;
      }).text(function(d) {
        return d.value;
      }).attr("class", "crosstab").style("font-size", cellHeight * 0.8);
      colrect = g.append("g").attr("id", "colrect");
      colrect.selectAll("empty").data(data.xcat).enter().append("rect").attr("x", function(d, i) {
        return xscale(i + 1);
      }).attr("y", yscale(0)).attr("width", cellWidth).attr("height", cellHeight).attr("fill", "none").attr("stroke", "none").on("mouseover", function() {
        return d3.select(this).attr("fill", hilitcolor);
      }).on("mouseout", function() {
        return d3.select(this).attr("fill", "none");
      });
      collab = g.append("g").attr("id", "collab");
      return collab.selectAll("empty").data(data.xcat).enter().append("text").attr("x", function(d, i) {
        return xscale(i + 1) + cellWidth - cellPad;
      }).attr("y", yscale(0) + cellHeight / 2).text(function(d) {
        return d;
      }).attr("class", "crosstab").style("font-size", cellHeight * 0.8);
    });
  };
  chart.cellHeight = function(value) {
    if (!arguments.length) {
      return cellHeight;
    }
    cellHeight = value;
    return chart;
  };
  chart.cellWidth = function(value) {
    if (!arguments.length) {
      return cellWidth;
    }
    cellWidth = value;
    return chart;
  };
  chart.margin = function(value) {
    if (!arguments.length) {
      return margin;
    }
    margin = value;
    return chart;
  };
  chart.axispos = function(value) {
    if (!arguments.length) {
      return axispos;
    }
    axispos = value;
    return chart;
  };
  chart.titlepos = function(value) {
    if (!arguments.length) {
      return titlepos;
    }
    titlepos;
    return chart;
  };
  chart.title = function(value) {
    if (!arguments.length) {
      return title;
    }
    title = value;
    return chart;
  };
  chart.xlab = function(value) {
    if (!arguments.length) {
      return xlab;
    }
    xlab = value;
    return chart;
  };
  chart.ylab = function(value) {
    if (!arguments.length) {
      return ylab;
    }
    ylab = value;
    return chart;
  };
  return chart;
};
