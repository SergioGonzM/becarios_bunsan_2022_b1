{:ok, connection} = AMQP.Connection.open
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, "task_queue_fixed1", durable: true)

message =
  case System.argv do
    []    -> "Hello World!"
    words -> Enum.join(words, " ")
  end

AMQP.Basic.publish(channel, "", "task_queue_fixed1", message, persistent: true)

IO.puts " [x] Send '#{message}'"

AMQP.Connection.close(connection)