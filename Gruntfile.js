module.exports = function(grunt){
    //Enable plug-ins
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-shell');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    //Build targets

    //Default target
    grunt.registerTask('default', ['build']);

    //Build
    grunt.registerTask('build', ['copy:full' , 'copy:lib']);

    //Uninstall from R
    grunt.registerTask('uninstall', ['shell:removeLibFromR']);

    //Install into R
    grunt.registerTask('install', ['uninstall', 'build', 'shell:installLibIntoR']);

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        dist:{
            root : './dist'
        },

        src:{
            root: './src',
            lib: './lib'
        },

        package :{
            name : 'testwidget'
        },
/*
        coffee: {
            options: {
                bare: true
            },
            compile: {
                files: {
                    'inst/htmlwidgets/lib/panels/scatterplot/scatterplot.js': 'inst/htmlwidgets/lib/panels/scatterplot/scatterplot.coffee',
                    'inst/htmlwidgets/lib/panels/panelutil.js': 'inst/htmlwidgets/lib/panels/panelutil.coffee',
                    'inst/htmlwidgets/iplot.js' : 'inst/htmlwidgets/iplot.coffee'
                }
            }
        },
*/
        copy: {
            full: {
                files: [{
                    expand: true,
                    cwd: '<%= src.root %>',
                    src: ['**'],
                    dest: '<%= dist.root %>'
                }]
            },
            lib:{
                files:[{
                    expand: true,
                    cwd: '<%= src.lib %>',
                    src: ['**'],
                    dest: '<%= dist.root %>' + '/' + '<%= package.name %>' + "/inst/htmlwidgets/lib/"
                }]
            }
        },

        shell: {
            options: {
                stderr: true,
                failOnError : false
            },
            buildDocs: {
                command: "R -e 'library(devtools);document()'"
            },
            installLibIntoR: {
                command: "R -e 'setwd(\"'<%= dist.root %>'/'<%= package.name %>'\");devtools::install()'"
            },
            removeLibFromR:{
                command: "R -e 'remove.packages(\"'<%= package.name %>'\")'"
            }
        },

        clean: {
            options:{
                force : true
            },
            all: ["./<%= dist.root %>"]
        },

        watch: {
            scripts: {
                files: ['**/*.js', '**/*.R'],
                tasks: ['install'],
                options: {
                        nospawn: true
                }
            }
        }


    });

};
