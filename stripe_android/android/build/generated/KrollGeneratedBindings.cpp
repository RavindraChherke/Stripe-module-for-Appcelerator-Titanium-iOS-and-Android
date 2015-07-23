/* C++ code produced by gperf version 3.0.3 */
/* Command-line: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/gperf -L C++ -E -t /private/var/folders/db/wv9d79d533v2fglp_3mblcxw0000gn/T/Ravindra/stripe_android-generated/KrollGeneratedBindings.gperf  */
/* Computed positions: -k'' */

#line 3 "/private/var/folders/db/wv9d79d533v2fglp_3mblcxw0000gn/T/Ravindra/stripe_android-generated/KrollGeneratedBindings.gperf"


#include <string.h>
#include <v8.h>
#include <KrollBindings.h>

#include "com.ravindra.stripe.StripeAndroidModule.h"
#include "com.ravindra.stripe.ExampleProxy.h"


#line 14 "/private/var/folders/db/wv9d79d533v2fglp_3mblcxw0000gn/T/Ravindra/stripe_android-generated/KrollGeneratedBindings.gperf"
struct titanium::bindings::BindEntry;
/* maximum key range = 8, duplicates = 0 */

class StripeAndroidBindings
{
private:
  static inline unsigned int hash (const char *str, unsigned int len);
public:
  static struct titanium::bindings::BindEntry *lookupGeneratedInit (const char *str, unsigned int len);
};

inline /*ARGSUSED*/
unsigned int
StripeAndroidBindings::hash (register const char *str, register unsigned int len)
{
  return len;
}

struct titanium::bindings::BindEntry *
StripeAndroidBindings::lookupGeneratedInit (register const char *str, register unsigned int len)
{
  enum
    {
      TOTAL_KEYWORDS = 2,
      MIN_WORD_LENGTH = 32,
      MAX_WORD_LENGTH = 39,
      MIN_HASH_VALUE = 32,
      MAX_HASH_VALUE = 39
    };

  static struct titanium::bindings::BindEntry wordlist[] =
    {
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""},
#line 17 "/private/var/folders/db/wv9d79d533v2fglp_3mblcxw0000gn/T/Ravindra/stripe_android-generated/KrollGeneratedBindings.gperf"
      {"com.ravindra.stripe.ExampleProxy", ::com::ravindra::stripe::stripeandroid::ExampleProxy::bindProxy, ::com::ravindra::stripe::stripeandroid::ExampleProxy::dispose},
      {""}, {""}, {""}, {""}, {""}, {""},
#line 16 "/private/var/folders/db/wv9d79d533v2fglp_3mblcxw0000gn/T/Ravindra/stripe_android-generated/KrollGeneratedBindings.gperf"
      {"com.ravindra.stripe.StripeAndroidModule", ::com::ravindra::stripe::StripeAndroidModule::bindProxy, ::com::ravindra::stripe::StripeAndroidModule::dispose}
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      unsigned int key = hash (str, len);

      if (key <= MAX_HASH_VALUE)
        {
          register const char *s = wordlist[key].name;

          if (*str == *s && !strcmp (str + 1, s + 1))
            return &wordlist[key];
        }
    }
  return 0;
}
#line 18 "/private/var/folders/db/wv9d79d533v2fglp_3mblcxw0000gn/T/Ravindra/stripe_android-generated/KrollGeneratedBindings.gperf"

