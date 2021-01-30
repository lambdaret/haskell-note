
import Control.Exception
import Data.Typeable
import Control.Monad.Catch

data SomethingBad = SomethingBad
    deriving Typeable
instance Show SomethingBad where
    show SomethingBad = "something bad happened"
instance Exception SomethingBad
foo x = do
    if x then return "abc" else throwM SomethingBad
