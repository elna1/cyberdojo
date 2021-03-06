#!/usr/bin/env ruby

require_relative '../test_helper'
require_relative 'integration_test'

class ReverterControllerTest  < IntegrationTest

  test "revert" do
    id = checked_save_id
    get 'dojo/enter_json', :id => id
    avatar_name = json['avatar_name']
    post '/kata/edit', :id => id, :avatar => avatar_name

    post 'kata/run_tests', # 1
      :id => id,
      :avatar => avatar_name,
      :file_content => {
        'cyber-dojo.sh' => "echo abc"
      },
      :file_hashes_incoming => {
        'cyber-dojo.sh' => 234234
      },
      :file_hashes_outgoing => {
        'cyber-dojo.sh' => -4545645678
      }

    post 'kata/run_tests', # 2
      :id => id,
      :avatar => avatar_name,
      :file_content => {
        'cyber-dojo.sh' => "echo def"
      },
      :file_hashes_incoming => {
        'cyber-dojo.sh' => 234234
      },
      :file_hashes_outgoing => {
        'cyber-dojo.sh' => -4545645678
      }

    get 'reverter/revert',
      :format => :json,
      :id => id,
      :avatar => avatar_name,
      :tag => 1

    visible_files = json['visibleFiles']
    assert_not_nil visible_files
    assert_not_nil visible_files['output']
    assert_not_nil visible_files['cyber-dojo.sh']

    assert_equal "echo abc", visible_files['cyber-dojo.sh']

    light = json['light']
    assert_not_nil light
    assert_equal "amber", light['colour']
    assert_equal 1, light['number']
  end

end
