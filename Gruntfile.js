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
    grunt.registerTask('build', ['clean', 'copy:src' , 'copy:lib', 'coffee']);

    //Uninstall from R
    grunt.registerTask('uninstall', ['shell:removeLibFromR']);

    //Install into R
    grunt.registerTask('install', ['uninstall', 'build', 'shell:installLibIntoR']);

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        dist:{
            root : './dist',
            qtlchartsroot : '<%= dist.root %>/qtlcharts'
        },

        src:{
            root: './src',
            lib: './lib'
        },

        package :{
            name : 'qtlcharts'
        },

        coffee: {
            options: {
                bare: true
            },
            compileQtlCharts: {
                expand: true,
                flatten: true,
                cwd: '<%= src.lib %>' + '/qtlcharts/',
                src: ['*.coffee'],
                dest: '<%= dist.qtlchartsroot %>/inst/htmlwidgets/lib/qtlcharts/',
                ext: '.js'
            },
            compileWidgets:{
                expand: true,
                flatten: true,
                cwd: '<%= src.root %>' + '/inst/htmlwidgets/',
                src: ['*.coffee'],
                dest: '<%= dist.qtlchartsroot %>/inst/htmlwidgets/',
                ext: '.js'
            }
        },

        copy: {
            src: {
                files: [{
                    expand: true,
                    cwd: '<%= src.root %>',
                    src: ['**','!**/*.coffee'],
                    dest: '<%= dist.qtlchartsroot %>'
                }]
            },
            lib:{
                files:[{
                    expand: true,
                    cwd: '<%= src.lib %>',
                    src: ['**','!qtlcharts/*.coffee'],
                    dest: '<%= dist.qtlchartsroot %>' + "/inst/htmlwidgets/lib/"
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
                command: "R -e 'setwd(\"'<%= dist.qtlchartsroot %>'\");devtools::install()'"
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
