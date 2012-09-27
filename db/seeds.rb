# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

provincials = JSON.parse(File.read(File.join(Rails.root, 'db/provincial.json')))
provincials.each_index do
  | i |

  p_code = (i + 10) * 10000
  provincials[i].each do
    | provincial, cities |

    r = Region.new(title: provincial, level: 1)
    r.id = p_code
    r.save
    cities.each_index do
      | j |

      c_code = p_code + (j + 10) * 100
      cities[j].each do
        | city, districts |

        r = Region.new(title: city, level: 2)
        r.id = c_code
        r.parent_id = p_code
        r.save
        districts.each_index do
          | k |

          d_code = c_code + (k + 10)
          r = Region.new(title: districts[k], level: 3)
          r.id = d_code
          r.parent_id = c_code
          r.save
        end
      end
    end
  end
end


c1 = Category.create(:name => '男装')
c1.children.create(:name => '夹克')
c1.children.create(:name => '风衣')
c1.children.create(:name => '裤子')

c2 = Category.create(:name => '女装')
c2.children.create(:name => '风衣')
c2.children.create(:name => '外套')
c2.children.create(:name => '裙子')

c3 = Category.create(:name => '箱包')
c3.children.create(:name => '旅行箱')
c3.children.create(:name => '挎包')