{-# LANGUAGE QuasiQuotes #-}
import Text.Lucius
import qualified Data.Text.Lazy.IO as TLIO

render = undefined

transition val = 
    [luciusMixin|
        -webkit-transition: #{val};
        -moz-transition: #{val};
        -ms-transition: #{val};
        -o-transition: #{val};
        transition: #{val};
    |]

myCSS = 
    [lucius|
        .some-class {
            ^{transition "all 4s ease"}
        }
    |]

main = TLIO.putStrLn $ renderCss $ myCSS render
