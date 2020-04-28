title 'S3 Website tests'

control 's3-bucket-check' do
  impact 1.0
  title 'Check to see if the s3 buckets exists and is configured as expected, some tests should fail'
  aws_s3_buckets.bucket_names.each do |bucket_name|
      if bucket_name.include? ''
      describe aws_s3_bucket(bucket_name: bucket_name) do
        it { should exist }
        it { should be_public }
        its('region') { should eq 'eu-west-2' }
        it { should have_access_logging_enabled }
        it { should_not have_default_encryption_enabled }
      end
    end
  end
end