require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

#=begin
  def test_post_sshkey2
    tmp_hash = {
      :name => "test_sample",
      :org_id => "ORG123",
      :privatekey => "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAz9g/LhHB7fDo85vm2O9F1oDzJhTs6PI3N6WDayZEzG4xmrZd
lUgRoPAbYxYoiENeXwK9cy3D8lvqCVCog0E2oDXc7fe+LiLA+J+MYEkGfhs7hYfc
snLY36w52U0rVSVzwxakZXbT5yPTFaKYO+48hqRonVrM25lPjfkc/d15Mg4v8/iV
q9p5Tc1jnVg5CATlzPtXk3tdEXgHcy7bz9HSL5mcTREKpUKJjHoAr1qi5A/wB9g1
w45wshACuMhMcRIWzbqYaHf20yphGOQ/Dz3pxHygmJHemOctrdMFAmHzlY7QgE1f
dFRTeKKna0rJTJ7sUTf6IuwFt0QsqePnN5bTiQIDAQABAoIBAAJ9U5xoqAsClLe+
SVCV5R9Boif1njTYGeM3v1A8QBy2wS9aOdq850EnPxy7ujaPoATBUqWbibpQcYg1
CB+yW0Yl/wR2sDd7QRZ5SsQoe8Rs7RSXYQReLczYEkVREFDPxwgyMDvq5XTiT/f1
X59wJhdyxrID0Wpb9sD7l+ZOjdIUpeIiM08aEUScZDMro3E2RhKt9Pg9wfqukh5V
i2104AK0NWJphu6yUI4XnnQm13+N6NIthj8DowgWM9NuR7fSsp4Z6I0QSy44Ls+2
5yvJbW5H+Tp/cI6LxaNYQMtikVBAIFNTXQASQDbcWwL1RJFmTQUqvH0ICdCdf5nX
aXqqQAECgYEA98Aoi3ea9bEJRdXYj62GdyZarFkyOFrseVO27UrUP2QWJU4LGciH
ccEG6QFm4L2/z4g0l3VyTpx96nyriXAUWVkn2inb0csy7DhXR9fXCzn4agtlwHCJ
dsCU8nJ/esubck/OHHqzrPFkSEG8PBMw/98lk9sB6pcj8YM3qjOWK4kCgYEA1sPt
kmvkFNaZdP6qLsh8tW7aLe9eRNrj/1DSV9qo9RfAvt12Vol9s4t5b84kIzPgeSxe
BIeLUsP3N/zPwAkCKXcCtsDHw65+IcBbwnyrSEwYwVKUdOiqnhqbnzxH/ecoVjce
85ZoI7hNFqmg9/jmxna3hqRb+FgdjTia2YaJaAECgYEA87DIcL6Z5pdXpqB8nn6x
p9tLDwHBWxtcRM7qPKgA88Vv3wvP8XGEgIi8Uk51shQSaoDwMhZs9BQL6qzsUYi0
C1qdz4Ki3M4BbcbRWzJcLIe96BkD4fEP1YYCPCQRbmh9o0gKVYr/1tmtqUE3dOPv
q48DuFaQoP4/dZx7EWgiivkCgYEAjpRSw7OXH3J9PJvZdeeqS3WFqZtRtVqwpQ8O
Jj9HjjevwccbSkZLSoidHWn4udo1+5xF6rHmABOTq/rOHcqdQdP93EBOHw5YNKYV
BSBpQj0q7iWZ46eXphE6IdQOY3U0ZVCA3uyKxLQVkacZ86at5zJnkx7I5C3zqI7c
1u8niAECgYEAkXXNaH5iY5UmQIWCj50ksEi8TA9obYcKtRC4PL80iwvRUK3QDKv2
7MYUIar1YtZWoZub0wsnPxYw8oiANR6hXQvTrfkM+3Hb+2wUrWycQ0FkJ5We+ldE
txyXl+iiF1+Nco4t/Jj3VvgzoIa25oQp2aeQhY7oot04UyyOYkPkkRQ=
-----END RSA PRIVATE KEY-----",
      :publickey => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDP2D8uEcHt8Ojzm+bY70XWgPMmFOzo8jc3pYNrJkTMbjGatl2VSBGg8BtjFiiIQ15fAr1zLcPyW+oJUKiDQTagNdzt974uIsD4n4xgSQZ+GzuFh9yyctjfrDnZTStVJXPDFqRldtPnI9MVopg77jyGpGidWszbmU+N+Rz93XkyDi/z+JWr2nlNzWOdWDkIBOXM+1eTe10ReAdzLtvP0dIvmZxNEQqlQomMegCvWqLkD/AH2DXDjnCyEAK4yExxEhbNuphod/bTKmEY5D8PPenEfKCYkd6Y5y2t0wUCYfOVjtCATV90VFN4oqdrSslMnuxRN/oi7AW3RCyp4+c3ltOJ",
      }
    response = megams.post_sshkey(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

#=begin
  def test_get_sshkeys
    response = megams.get_sshkeys
    assert_equal(200, response.status)
  end
#=end
end
