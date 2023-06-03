# iac

## List Components

- **Bucket** - `terraform-capstone-repoth` (To store terraform state).
- **Compute Engine** - `testing` :
  | Key          | Value                           |
  | --------     | --------                        |
  | machine_type | "n1-standard-2"                 |
  | zone         | "asia-southeast2-a"             |
  | image        | Ubuntu-20.24                    | 
  | tags         | ["http-server", "https-server"] |
  | network      | "default"                       |

- **Network** - `testing`
- **Reserved IP** - `public-ip`
  | Key          | Value           |
  | --------     | --------        |
  | ipv4         | 34.128.127.155  |

- **Firewall** - `testing-firewall`
  | Key           | Value                 |
  | --------      | --------              |
  | tcp           | ["22", "80", "8080", "8443"]  |
  | source_ranges | [ "0.0.0.0/0" ]       |
  | target_tags   | [ "all" ]             |