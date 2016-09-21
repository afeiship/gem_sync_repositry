#!/usr/bin/env ruby -wKU
require 'rugged'
require 'ruby-progressbar'
class SyncRepositry
    def self.hi
        puts 'Hello world!'
    end

    def self.clone_repositry (inUrl, inPath)
      progressbar = ProgressBar.create( :format => "%a %b %c/%C\u{15E7}%i %p%% %t",
                          :progress_mark  => '=',
                          :throttle_rate => 0.1,
                          :remainder_mark => "\u{FF65}",
                          :starting_at    => 0)
      # puts Rugged::Repository.attributes_name;
      Rugged::Repository.clone_at(inUrl, inPath, {
        checkout_branch:'master',
        transfer_progress:lambda { |total_objects, indexed_objects, received_objects, local_objects, total_deltas, indexed_deltas, received_bytes|
          if received_objects == 0
            progressbar.total = total_objects;
          end
          if (received_objects < total_objects) && (progressbar.progress < progressbar.total)
            progressbar.increment;
          end
        }
      });
    end
end