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
    linewidth = chartOpts?.linewidth ? 2 # line width for LOD curves (lower panel)
    eff_linewidth = chartOpts?.eff_linewidth ? 2 # width of line for effect plot (right panel)
    nxticks = chartOpts?.nxticks ? 5 # no. ticks in x-axis for effect plot (right panel), if quantitative scale
    xticks = chartOpts?.xticks ? null # tick positions in x-axis for effect plot (right panel), if quantitative scale
    lod_labels = chartOpts?.lod_labels ? null # optional vector of strings, for LOD column labels
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

    console.log(lod_data)

    data = [ [ 0.85392, 4.7951, null ],
             [ 1.9479, 6.6572, null ],
             [ 3.4672, 5.1628, null ]
             [ 0.5341, null, null ],
             [ 0.86976, null, 11.845 ],
             [ 1.0733, null, 9.1581 ],
             [ 2.2701, null, 7.4126 ],
             [ 1.3735, null, 9.1597 ],
             [ 1.9994, null, 4.9451 ],
             [ 2.8514, 7.7496,   11.8 ],
             [ 3.0381, 10.033, 15.951 ],
             [  2.623, 6.2569, 10.064 ],
             [ 2.8918, 2.1806, 2.7553 ],
             [ 3.1928, 3.8717,  11.03 ],
             [ 2.8945, 4.6485, 7.5412 ],
             [ 1.7352,  2.323, 8.5668 ],
             [ 3.6079, 7.5651, 13.068 ],
             [ 0.29697, 0.96564, 4.7644 ],
             [ 4.2971, 7.6257, 13.682 ],
             [ 1.4184, 3.9942, 7.4658 ],
             [ 2.6927, 6.0563, 9.8373 ],
             [ 3.3326, 5.2795, 9.4982 ],
             [ 0.91039,  7.124, 16.547 ],
             [ 2.9352, 5.6384, 12.084 ],
             [  2.247, 4.9576, 11.219 ],
             [ 1.8186, 6.6697, 15.099 ],
             [ 2.6873, 5.9696, 12.492 ],
             [ 1.5871, 7.1438, 16.851 ],
             [ 0.64619, 4.6698, 8.4931 ],
             [ 1.1519, 5.5712, 10.065 ],
             [ 0.97719, 5.8791, 13.075 ],
             [ 1.4067, 4.9597, 13.569 ],
             [ 2.0785, 1.2614, 4.4511 ],
             [ 1.6042, 2.9743, 9.1356 ],
             [ 1.6446, 4.0385, 7.7958 ],
             [ 0.8464, 2.6913, 10.386 ],
             [ 2.0101, 7.8212, 12.579 ],
             [ 0.61775, -0.37013, 6.0409 ],
             [ 2.3648, 3.5159, 9.3037 ],
             [ 1.2657,  2.586, 8.6622 ],
             [ 1.6426, 2.6698, 10.807 ],
             [ 1.7594, 5.8972, 11.623 ],
             [ 0.89567, 5.3262,  10.93 ],
             [ 1.1821, 3.8296, 9.9749 ],
             [ 1.8198, 6.7594, 12.653 ],
             [ 1.4634, 3.0375, 9.3865 ],
             [ 3.7619, 9.4365, 14.281 ],
             [ 1.4458, 3.2316, 8.5586 ]]

    myscatterplot = scatterplot()
      .xvar(0)
      .yvar(1)
      .xlab("X1")
      .ylab("X2")
      .height(hbot-margin.top-margin.bottom)
      .width(wleft-margin.left-margin.right)
      .margin(margin)

    g_scatterplot = svg.append("g")
      .attr("transform", "translate(0,#{htop})")
      .attr("id", "scatterplot")
      .datum({data:data})
      .call(myscatterplot)

    ###
    myscatterplot = lodchart().height(hbot-margin.top-margin.bottom)
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

    g_scatterplot = svg.append("g")
                    .attr("transform", "translate(0,#{htop})")
                    .attr("id", "lodchart")
                    .datum(lod_data)
                    .call(myscatterplot)

    # function for lod curve path
    lodcurve = (chr, lodcolumn) ->
                  d3.svg.line()
                    .x((d) -> myscatterplot.xscale()[chr](d))
                    .y((d,i) -> myscatterplot.yscale()(Math.abs(lod_data.lodByChr[chr][i][lodcolumn])))
    ###



#    eff_ylim = eff_ylim ? matrixExtent(eff_data.map((d) -> matrixExtent(d.data)))
#    eff_nlines = d3.max(eff_data.map((d) -> d.names.length))
#    eff_linecolor = eff_linecolor ? selectGroupColors(eff_nlines, "dark")
#/*
#    mycurvechart = curvechart().height(htop-margin.top-margin.bottom)
#                               .width(wright-margin.left-margin.right)
#                               .margin(margin)
#                               .axispos(axispos)
#                               .titlepos(titlepos)
#                               .xlab(lod_ylab)
#                               .ylab(eff_ylab)
#                               .strokecolor("none")
#                               .rectcolor(lightrect)
#                               .xlim([-0.5, lod_data.lodnames.length-0.5])
#                               .ylim(eff_ylim)
#                               .nxticks(0)
#                               .commonX(true)
#
#    g_curvechart = svg.append("g")
#                      .attr("transform", "translate(#{wleft},0)")
#                      .attr("id", "curvechart")
#                      .datum(eff_data[0])
#                      .call(mycurvechart)
#
#    # function for eff curve path
#    effcurve = (posindex, column) ->
#                  d3.svg.line()
#                    .x((d) -> mycurvechart.xscale()(d))
#                    .y((d,i) -> mycurvechart.yscale()(eff_data[posindex].data[column][i]))
#
#    # plot effect curves for a given position
#    effchart_curves = null
#    plotEffCurves = (posindex) ->
#        effchart_curves = g_curvechart.append("g").attr("id", "curves")
#        for curveindex of eff_data[posindex].names
#            effchart_curves.append("path")
#                           .datum(eff_data[posindex].x)
#                           .attr("d", effcurve(posindex,curveindex))
#                           .attr("fill", "none")
#                           .attr("stroke", eff_linecolor[curveindex])
#                           .attr("stroke-width", eff_linewidth)
#            effchart_curves.selectAll("empty")
#                           .data(eff_data[posindex].names)
#                           .enter()
#                           .append("text")
#                           .text((d) -> d)
#                           .attr("x", (d,i) -> margin.left + wright + axispos.ylabel)
#                           .attr("y", (d,i) ->
#                                     z = eff_data[posindex].data[i]
#                                     mycurvechart.yscale()(z[z.length-1]))
#                           .style("dominant-baseline", "middle")
#                           .style("text-anchor", "start")
#*/
    # add X axis
#    if times? # use quantitative axis
#        xscale = d3.scale.linear().range(mycurvechart.xscale().range())
#        xscale.domain([times[0], times[times.length-1]])
#        xticks = xticks ? xscale.ticks(nxticks)
#        curvechart_xaxis = g_curvechart.select("g.x.axis")
#        curvechart_xaxis.selectAll("empty")
#                        .data(xticks)
#                        .enter()
#                        .append("line")
#                        .attr("x1", (d) -> xscale(d))
#                        .attr("x2", (d) -> xscale(d))
#                        .attr("y1", margin.top)
#                        .attr("y2", margin.top+htop)
#                        .attr("fill", "none")
#                        .attr("stroke", "white")
#                        .attr("stroke-width", 1)
#                        .style("pointer-events", "none")
#        curvechart_xaxis.selectAll("empty")
#                        .data(xticks)
#                        .enter()
#                        .append("text")
#                        .attr("x", (d) -> xscale(d))
#                        .attr("y", margin.top+htop+axispos.xlabel)
#                        .text((d) -> formatAxis(xticks)(d))
#    else # qualitative axis
#        curvechart_xaxis = g_curvechart.select("g.x.axis")
#                                       .selectAll("empty")
#                                       .data(lod_labels)
#                                       .enter()
#                                       .append("text")
#                                       .attr("class", "y axis")
#                                       .attr("id", (d,i) -> "xaxis#{i}")
#                                       .attr("x", (d,i) -> mycurvechart.xscale()(i))
#                                       .attr("y", margin.top+htop+axispos.xlabel)
#                                       .text((d) -> d)
#                                       .attr("opacity", 0)

    # hash for [chr][pos] -> posindex
    posindex = {}
    curindex = 0
    for chr in lod_data.chrnames
        posindex[chr] = {}
        for pos in lod_data.posByChr[chr]
            posindex[chr][pos] = curindex
            curindex += 1

#    mycurvechart.curvesSelect()
#                .on("mouseover.panel", null)
#                .on("mouseout.panel", null)

    mylodheatmap.cellSelect()
                .on "mouseover", (d) ->
                         #plotLodCurve(d.lodindex)
                         g_scatterplot.select("g.title text").text("#{lod_labels[d.lodindex]}")
                         #plotEffCurves(posindex[d.chr][d.pos])
                         p = d3.format(".1f")(d.pos)
                         #g_curvechart.select("g.title text").text("#{d.chr}@#{p}")
                         #g_curvechart.select("text#xaxis#{d.lodindex}").attr("opacity", 1)
                         return
                .on "mouseout", (d) ->
                         #lodchart_curves.remove()
                         g_scatterplot.select("g.title text").text("")
                         #effchart_curves.remove()
                         #g_curvechart.select("g.title text").text("")
                         #g_curvechart.select("text#xaxis#{d.lodindex}").attr("opacity", 0)
                         return
                .on "click", (d) ->
                         alert("hello")