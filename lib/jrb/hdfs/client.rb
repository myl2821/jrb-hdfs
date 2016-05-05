require "jrb/hdfs/version"

module Jrb
  module Hdfs
    class Client
      java_import 'org.apache.hadoop.fs.Path'
      java_import 'org.apache.hadoop.security.UserGroupInformation'
      java_import 'org.apache.hadoop.conf.Configuration'
      java_import 'java.net.URI'
      java_import 'org.apache.hadoop.fs.FileUtil'
      # Constructor
      #
      # @param [String]uri  uri of hdfs namenode
      # @param [String]conf_path  configure dir of hadoop
      # @param [Hash]opts
      #   [Array[String]]conf_files  configure file that to be added into hdfs_conf resource
      #   [boolean]use_kerberos  if use kerberos
      #   [String]kerberos_username
      #   [String]kerberos_keytab_path
      def initialize(uri, conf_path, opts={})
        @uri = uri
        @hdfs_conf = Configuration.new
        @hdfs_conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem")

        conf_files = opts[:conf_files] || ['core-site.xml', 'hdfs-site.xml']
        conf_files.each do |config_file|
          @hdfs_conf.add_resource(Path.new(File.join(conf_path, config_file)))
        end

        if opts[:use_kerberos] == true
          @hdfs_conf.set("hadoop.security.authentication", "kerberos")
          UserGroupInformation.setConfiguration(@hdfs_conf)
          UserGroupInformation.loginUserFromKeytab(opts[:kerberos_username], opts[:kerberos_keytab_path])
        end

        @hdfs = org.apache.hadoop.fs.FileSystem.get(URI.create(uri), @hdfs_conf)
      end

      # Get list of hdfs entry
      #
      # @param [String]path
      # @param [Boolean]recursively
      #
      # @return [Array[org.apache.hadoop.fs.Path]]
      def list(path, recursively=false)
        if recursively
          paths = []
          dir_itr = @hdfs.listFiles(Path.new(path), true)

          while dir_itr.hasNext
            next_path = dir_itr.next.getPath
            paths << next_path
          end
          paths
        else
          file_status = @hdfs.listStatus(Path.new(path))
          FileUtil.stat2Paths(file_status)
        end
      end

      # Copy a hdfs file to local fs
      #
      # @param [String]hdfs_src
      # @param [String]local_dst
      #
      # @return [Boolean]
      def copy_to_local(hdfs_src, local_dst)
        return false unless exists?(hdfs_src)
        begin
          @hdfs.copy_to_local_file(false, Path.new(hdfs_src), Path.new(local_dst), true)
          true
        rescue
          false
        end
      end

      # Check if entry exists in hdfs
      #
      # @param [String]path
      #
      # @return [Boolean]
      def exists?(path)
        @hdfs.exists(Path.new(path))
      end

      # Remove a hdfs entry
      #
      # @param [String]path
      # @param [Boolean]recursively
      #
      # @return [Boolean]
      def rm(path, recursively=false)
        return false unless exists?(path)
        @hdfs.delete(Path.new(path), recursively)
      end

      # Put local entry into hdfs
      #
      # @param [String]local_src
      # @param [String]hdfs_dst
      #
      # @return [Boolean]
      def put(local_src, hdfs_dst)
        return false unless File.exists?(local_src)
        begin
          @hdfs.copyFromLocalFile(false, true, Path.new(local_src), Path.new(hdfs_dst))
          true
        rescue
          false
        end
      end

      # Mkdir in hdfs
      #
      # @param [String]path
      #
      # @return [Boolean]
      def mkdir(path)
        @hdfs.mkdirs(Path.new(path))
      end

      alias :mkdir_p :mkdir
    end
  end
end
