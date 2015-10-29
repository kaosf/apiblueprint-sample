gulp            = require 'gulp'
aglio           = require 'gulp-aglio'
browserSync     = require 'browser-sync'
watch           = require 'gulp-watch'
rimraf          = require 'rimraf'
runSequence     = require 'run-sequence'

$DEST   = './public/'
$SRC    = './app/'
path =
    $SRC:  $SRC
    $DEST: $DEST
    src:
        md: ["#{$SRC}/md/**/*.md"]
    dest:
        html: $DEST


gulp.task 'clean', (cb)->
    rimraf path.$DEST, cb

gulp.task 'aglio', ->
    gulp.src path.src.md
        .pipe aglio
            template: 'default'
        .pipe gulp.dest path.dest.html
        .pipe browserSync.reload
            stream: true

gulp.task 'browser-sync', ->
    browserSync.init null,
        server: path.$DEST
        reloadDelay: 1000

gulp.task 'watch', ->
    watch path.src.md, ->
        gulp.start ['aglio']

gulp.task 'default', ->
    runSequence 'clean', 'aglio', ['browser-sync', 'watch']
