# -*- coding: utf-8 -*-
require 'spec_helper'

describe VersionMatcher do
  shared_examples 'parsed_match' do |version, match_str|
    let(:version_matcher) { VersionMatcher.parse match_str }
    it { (version_matcher =~ version).should be_true }
  end

  context 'parsed matches' do
    it_behaves_like 'parsed_match', '1.2.3', '1.2.3'
    it_behaves_like 'parsed_match', '1.2.3', '=1.2.3'
    it_behaves_like 'parsed_match', '1.2.3', '>=1.2.3'
    it_behaves_like 'parsed_match', '1.2.3', '>1.2'
    it_behaves_like 'parsed_match', '1.2.3', '!1.2.4'
    it_behaves_like 'parsed_match', '1.2.3', '1.2-1.3'
    it_behaves_like 'parsed_match', '1.2.3', ''
  end
end
