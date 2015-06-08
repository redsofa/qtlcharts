# mplotMScanone_eff: based off of https://github.com/kbroman/qtlcharts/blob/6d19fc421c2284ec2e8bee39c736aece3d835e68/inst/htmlwidgets/lib/qtlcharts/iplotMScanone_noeff.coffee
# Original author is Karl W Broman.
# Modifications (and bugs) are Rene Richard's

mplotMScanone_eff = (widgetdiv, lod_data, eff_data, times, chartOpts) ->
  # chartOpts start
  height = chartOpts?.height ? 700 # height of chart in pixels
  width = chartOpts?.width ? 1000 # width of chart in pixels
  wleft = chartOpts?.wleft ? width*0.65 # width of left panels in pixels
  htop = chartOpts?.htop ? height/2 # height of top panels in pixels
  margin = chartOpts?.margin ? {left:60, top:40, right:40, bottom: 40, inner:5} # margins in pixels (left, top, right, bottom, inner)
  axispos = chartOpts?.axispos ? {xtitle:25, ytitle:30, xlabel:5, ylabel:5} # position of axis labels in pixels (xtitle, ytitle, xlabel, ylabel)
  titlepos = chartOpts?.titlepos ? 20 # position of chart title in pixels
  chrGap = chartOpts?.chrGap ? 8 # gap between chromosomes in pixels
  darkrect = chartOpts?.darkrect ? "#C8C8C8" # color of darker background rectangle
  lightrect = chartOpts?.lightrect ? "#E6E6E6" # color of lighter background rectangle
  nullcolor = chartOpts?.nullcolor ? "#E6E6E6" # color for pixels with null values
  colors = chartOpts?.colors ? ["slateblue", "white", "crimson"] # heat map colors
  zlim = chartOpts?.zlim ? null # z-axis limits
  zthresh = chartOpts?.zthresh ? null # lower z-axis threshold for display in heat map
  lod_ylab = chartOpts?.lod_ylab ? "" # y-axis label for LOD heatmap (also used as x-axis label on effect plot)
  eff_ylim = chartOpts?.eff_ylim ? null # y-axis limits for effect plot (right panel)
  eff_ylab = chartOpts?.eff_ylab ? "" # y-axis label for effect plot (right panel)
  linecolor = chartOpts?.linecolor ? "darkslateblue" # line color for LOD curves (lower panel)
  eff_linecolor = chartOpts?.eff_linecolor ? null # line color for effect plot (right panel)
  linewidth =  0 # line width for LOD curves (lower panel)
  eff_linewidth = chartOpts?.eff_linewidth ? 2 # width of line for effect plot (right panel)
  nxticks = chartOpts?.nxticks ? 5 # no. ticks in x-axis for effect plot (right panel), if quantitative scale
  xticks = chartOpts?.xticks ? null # tick positions in x-axis for effect plot (right panel), if quantitative scale
  lod_labels = chartOpts?.lod_labels ? null # optional vector of strings, for LOD column labels
  pointcolor = chartOpts?.pointcolor ? "slateblue" # color of points in at markers in LOD curves
  pointsize = 2 # size of points in LOD curves
  pointstroke = chartOpts?.pointstroke ? "black"
  # chartOpts end
  chartdivid = chartOpts?.chartdivid ? 'chart'

  wright = width - wleft
  hbot = height - htop

  # if quant scale, use times as labels; otherwise use lod_data.lodnames
  unless lod_labels?
    lod_labels = if times? then (formatAxis(times, extra_digits=1)(x) for x in times) else lod_data.lodnames

  mylodheatmap = lodheatmap().height(htop-margin.top-margin.bottom)
  .width(wleft-margin.left-margin.right)
  .margin(margin)
  .axispos(axispos)
  .titlepos(titlepos)
  .chrGap(chrGap)
  .rectcolor(lightrect)
  .colors(colors)
  .zlim(zlim)
  .zthresh(zthresh)
  .quantScale(times)
  .lod_labels(lod_labels)
  .ylab(lod_ylab)
  .nullcolor(nullcolor)

  svg = d3.select(widgetdiv).select("svg")

  g_heatmap = svg.append("g")
  .attr("id", "heatmap")
  .datum(lod_data)
  .call(mylodheatmap)

  mylodchart = lodchart().height(hbot-margin.top-margin.bottom)
  .width(wleft-margin.left-margin.right)
  .margin(margin)
  .axispos(axispos)
  .titlepos(titlepos)
  .chrGap(chrGap)
  .linecolor("none")
  .pad4heatmap(true)
  .darkrect(darkrect)
  .lightrect(lightrect)
  .ylim([0, d3.max(mylodheatmap.zlim())])
  .pointsAtMarkers(false)

  g_lodchart = svg.append("g")
  .attr("transform", "translate(0,#{htop})")
  .attr("id", "lodchart")
  .datum(lod_data)
  .call(mylodchart)

  # function for lod curve path
  lodcurve = (chr, lodcolumn) ->
    d3.svg.line()
    .x((d) -> mylodchart.xscale()[chr](d))
    .y((d,i) -> mylodchart.yscale()(Math.abs(lod_data.lodByChr[chr][i][lodcolumn])))

  # plot lod curves for selected LOD column
  lodchart_curves = null
  plotLodCurve = (lodcolumn) ->
    lodchart_curves = g_lodchart.append("g").attr("id", "lodcurves")
    for chr in lod_data.chrnames
      lodchart_curves.append("path")
      .datum(lod_data.posByChr[chr])
      .attr("d", lodcurve(chr, lodcolumn))
      .attr("stroke", linecolor)
      .attr("fill", "none")
      .attr("stroke-width", linewidth)
      .style("pointer-events", "none")
      if pointsize > 0
        lodchart_curves.append("g").attr("id", "lodpoints")
        .selectAll("empty")
        .data(lod_data.posByChr[chr])
        .enter()
        .append("circle")
        .attr("cx", (d) -> mylodchart.xscale()[chr](d))
        .attr("cy", (d,i) ->
          mylodchart.yscale()(Math.abs(lod_data.lodByChr[chr][i][lodcolumn])))
        .attr("r", pointsize)
        .attr("fill", pointcolor)
        .attr("stroke", pointstroke)

  mylodheatmap.cellSelect()
  .on "mouseover", (d) ->
    plotLodCurve(d.lodindex)
    g_lodchart.select("g.title text").text("#{lod_labels[d.lodindex]}")
    p = d3.format(".1f")(d.pos)
  .on "mouseout", (d) ->
    lodchart_curves.remove()
    g_lodchart.select("g.title text").text("")
