# LogStream

This is a simple real-time replication tool for growing log files build out of standard GNU tools.

Server side accepts connections on a single port, allowing multiple remote clients to receive data from multiple log files residing on server side as they grow (contents from multiple files is multiplexed on the server side and demultiplexed on the client side).
